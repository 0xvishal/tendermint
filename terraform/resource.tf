## Define SSH key pair for our instances
resource "aws_key_pair" "deployer" {
  key_name   = "golang"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCAJB/kErvYsQN14ioWg87mGJTSWJq9dk1hjCQ1nsXgTx4WKSyu9IIJ993IhJ/3ogOw2wIMIP8L3uUqaPqq9MuLQu9ohaHGawjk206TJKwZ9Ld3ISGNLn2uXoI4I4ytJT3Mn7KP0YYGUEu+2wrxyUGxSIGGyNk6dg9M0HW0V3TJywaVCreBH1TLqwZmj6qnbkycZxIe8mJoRiJSgP7akSWIKlnKle2fQ/kHeF0NZysWvlNjdrtkhuk6hqFge4H34WIuif8E20p8qA5Ky5a7JK5S8o5SwtK/Y7g88wFRfXhRLQl8587qz4jujTvwq78g/h2QieCPppZK5T4nAVUcxsNd vishal"
}

# Define webserver inside the public subnet
resource "aws_instance" "access" {
   ami  = "ami-0cfee17793b08a293"
   instance_type = "t2.nano"
   key_name = "${aws_key_pair.deployer.id}"
   subnet_id = "${aws_subnet.public-subnet1.id}"
   vpc_security_group_ids = ["${aws_security_group.public.id}"]
   associate_public_ip_address = true
   source_dest_check = false

  tags {
    Name = "multiserver-access"
  }

}

# Define ansible server inside the private subnet
resource "aws_instance" "ansible" {
   ami  = "${var.ami}"
   instance_type = "t1.micro"
   key_name = "${aws_key_pair.deployer.id}"
   subnet_id = "${aws_subnet.private-subnet3.id}"
   vpc_security_group_ids = ["${aws_security_group.golang.id}"]
   user_data = <<USER_DATA
#!/bin/bash
sudo apt-get update
sudo hostname ansible
sudo echo "ansible" > /etc/hostname
sudo echo "127.0.0.1 ansible" >> /etc/hosts
sudo apt-get install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt-get update
sudo apt-get install -y ansible
   USER_DATA
   source_dest_check = false
   tags {
    Name = "ansible"
  }

}

# Define golang1 inside the private subnet
resource "aws_instance" "golang1" {
   ami  = "${var.ami}"
   instance_type = "t1.micro"
   key_name = "${aws_key_pair.deployer.id}"
   subnet_id = "${aws_subnet.private-subnet3.id}"
   vpc_security_group_ids = ["${aws_security_group.golang.id}"]
   user_data = <<USER_DATA
#!/bin/bash
sudo apt-get update
sudo hostname golang1
sudo echo "golang1" > /etc/hostname
sudo echo "127.0.0.1 golang1" >> /etc/hosts
   USER_DATA
   source_dest_check = false
   tags {
    Name = "golang1"
  }

}

# Define golang2 inside the private subnet
resource "aws_instance" "golang2" {
   ami  = "${var.ami}"
   instance_type = "t1.micro"
   key_name = "${aws_key_pair.deployer.id}"
   subnet_id = "${aws_subnet.private-subnet1.id}"
   vpc_security_group_ids = ["${aws_security_group.golang.id}"]
   user_data = <<USER_DATA
#!/bin/bash
sudo apt-get update
sudo hostname golang2
sudo echo "golang2" > /etc/hostname
sudo echo "127.0.0.1 golang2" >> /etc/hosts
   USER_DATA
   source_dest_check = false
   tags {
    Name = "golang2"
  }

}

# Define golang3 inside the private subnet
resource "aws_instance" "golang3" {
   ami  = "${var.ami}"
   instance_type = "t1.micro"
   key_name = "${aws_key_pair.deployer.id}"
   subnet_id = "${aws_subnet.private-subnet2.id}"
   vpc_security_group_ids = ["${aws_security_group.golang.id}"]
   user_data = <<USER_DATA
#!/bin/bash
sudo apt-get update
sudo hostname golang3
sudo echo "golang3" > /etc/hostname
sudo echo "127.0.0.1 golang3" >> /etc/hosts
   USER_DATA
   source_dest_check = false
   tags {
    Name = "golang3"
  }

}

#Loadbalancer
resource "aws_elb" "bar" {
  name               = "foobar-terraform-elb"

  security_groups = ["${aws_security_group.public.id}"]
  subnets = ["${aws_subnet.public-subnet1.id}","${aws_subnet.public-subnet2.id}","${aws_subnet.public-subnet3.id}","${aws_subnet.public-subnet4.id}"]
    listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8080/"
    interval            = 30
  }

  instances                   = ["${aws_instance.golang1.id}","${aws_instance.golang2.id}","${aws_instance.golang3.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 10
  connection_draining         = true
  connection_draining_timeout = 10

  tags {
    Name = "terraform_elb"
  }
}

# Output
output "ELB Domain" {
  value = "${aws_elb.bar.dns_name}"
}
