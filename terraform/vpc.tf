# Define our VPC
resource "aws_vpc" "tendermint" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "Tendermint"
  }
}

# Define the public subnet1
resource "aws_subnet" "public-subnet1" {
  vpc_id = "${aws_vpc.tendermint.id}"
  cidr_block = "${var.public_subnet_cidr1}"
  availability_zone = "us-east-1a"

  tags {
    Name = "Public Subnet1"
  }
}

# Define the public subnet2
resource "aws_subnet" "public-subnet2" {
  vpc_id = "${aws_vpc.tendermint.id}"
  cidr_block = "${var.public_subnet_cidr2}"
  availability_zone = "us-east-1b"

  tags {
    Name = "Public Subnet2"
  }
}

# Define the public subnet3
resource "aws_subnet" "public-subnet3" {
  vpc_id = "${aws_vpc.tendermint.id}"
  cidr_block = "${var.public_subnet_cidr3}"
  availability_zone = "us-east-1c"

  tags {
    Name = "Public Subnet3"
  }
}

# Define the public subnet4
resource "aws_subnet" "public-subnet4" {
  vpc_id = "${aws_vpc.tendermint.id}"
  cidr_block = "${var.public_subnet_cidr4}"
  availability_zone = "us-east-1d"

  tags {
    Name = "Public Subnet4"
  }
}

# Define the public subnet5
resource "aws_subnet" "public-subnet5" {
  vpc_id = "${aws_vpc.tendermint.id}"
  cidr_block = "${var.public_subnet_cidr5}"
  availability_zone = "us-east-1e"

  tags {
    Name = "Public Subnet5"
  }
}

# Define the public subnet6
resource "aws_subnet" "public-subnet6" {
  vpc_id = "${aws_vpc.tendermint.id}"
  cidr_block = "${var.public_subnet_cidr6}"
  availability_zone = "us-east-1f"

  tags {
    Name = "Public Subnet6"
  }
}


# Define the private subnet1
resource "aws_subnet" "private-subnet1" {
  vpc_id = "${aws_vpc.tendermint.id}"
  cidr_block = "${var.private_subnet_cidr1}"
  availability_zone = "us-east-1a"

  tags {
    Name = "Private Subnet1"
  }
}

# Define the private subnet2
resource "aws_subnet" "private-subnet2" {
  vpc_id = "${aws_vpc.tendermint.id}"
  cidr_block = "${var.private_subnet_cidr2}"
  availability_zone = "us-east-1b"

  tags {
    Name = "Private Subnet2"
  }
}

# Define the private subnet3
resource "aws_subnet" "private-subnet3" {
  vpc_id = "${aws_vpc.tendermint.id}"
  cidr_block = "${var.private_subnet_cidr3}"
  availability_zone = "us-east-1c"

  tags {
    Name = "Private Subnet3"
  }
}

# Define the private subnet4
resource "aws_subnet" "private-subnet4" {
  vpc_id = "${aws_vpc.tendermint.id}"
  cidr_block = "${var.private_subnet_cidr4}"
  availability_zone = "us-east-1d"

  tags {
    Name = "Private Subnet4"
  }
}

# Define the private subnet5
resource "aws_subnet" "private-subnet5" {
  vpc_id = "${aws_vpc.tendermint.id}"
  cidr_block = "${var.private_subnet_cidr5}"
  availability_zone = "us-east-1e"

  tags {
    Name = "Private Subnet5"
  }
}

# Define the private subnet6
resource "aws_subnet" "private-subnet6" {
  vpc_id = "${aws_vpc.tendermint.id}"
  cidr_block = "${var.private_subnet_cidr6}"
  availability_zone = "us-east-1f"

  tags {
    Name = "Private Subnet6"
  }
}

# Define the internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.tendermint.id}"

  tags {
    Name = "VPC IGW"
  }
}

# Define the route table
resource "aws_route_table" "web-public-rt" {
  vpc_id = "${aws_vpc.tendermint.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "Public Subnet RT"
  }
}


# Creating Elastic IPa

resource "aws_eip" "lb" {

  vpc = true

}

resource "aws_nat_gateway" "gw" {
  allocation_id = "${aws_eip.lb.id}"
  subnet_id     = "${aws_subnet.public-subnet1.id}"

  tags = {
    Name = "gw NAT"
  }
}

# Define the route table
resource "aws_route_table" "web-private-rt" {
  vpc_id = "${aws_vpc.tendermint.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.gw.id}"
  }

  tags {
    Name = "Private Subnet RT"
  }
}

# Assign the route table to the private Subnet1
resource "aws_route_table_association" "web-private-rt1" {
  subnet_id = "${aws_subnet.private-subnet1.id}"
  route_table_id = "${aws_route_table.web-private-rt.id}"
}

# Assign the route table to the private Subnet2
resource "aws_route_table_association" "web-private-rt2" {
  subnet_id = "${aws_subnet.private-subnet2.id}"
  route_table_id = "${aws_route_table.web-private-rt.id}"
}

# Assign the route table to the private Subnet3
resource "aws_route_table_association" "web-private-rt3" {
  subnet_id = "${aws_subnet.private-subnet3.id}"
  route_table_id = "${aws_route_table.web-private-rt.id}"
}

# Assign the route table to the private Subnet4
resource "aws_route_table_association" "web-private-rt4" {
  subnet_id = "${aws_subnet.private-subnet4.id}"
  route_table_id = "${aws_route_table.web-private-rt.id}"
}

# Assign the route table to the private Subnet5
resource "aws_route_table_association" "web-private-rt5" {
  subnet_id = "${aws_subnet.private-subnet5.id}"
  route_table_id = "${aws_route_table.web-private-rt.id}"
}

# Assign the route table to the private Subnet6
resource "aws_route_table_association" "web-private-rt6" {
  subnet_id = "${aws_subnet.private-subnet6.id}"
  route_table_id = "${aws_route_table.web-private-rt.id}"
}




# Assign the route table to the public Subnet1
resource "aws_route_table_association" "web-public-rt1" {
  subnet_id = "${aws_subnet.public-subnet1.id}"
  route_table_id = "${aws_route_table.web-public-rt.id}"
}

# Assign the route table to the public Subnet2
resource "aws_route_table_association" "web-public-rt2" {
  subnet_id = "${aws_subnet.public-subnet2.id}"
  route_table_id = "${aws_route_table.web-public-rt.id}"
}

# Assign the route table to the public Subnet3
resource "aws_route_table_association" "web-public-rt3" {
  subnet_id = "${aws_subnet.public-subnet3.id}"
  route_table_id = "${aws_route_table.web-public-rt.id}"
}

# Assign the route table to the public Subnet4
resource "aws_route_table_association" "web-public-rt4" {
  subnet_id = "${aws_subnet.public-subnet4.id}"
  route_table_id = "${aws_route_table.web-public-rt.id}"
}

# Assign the route table to the public Subnet5
resource "aws_route_table_association" "web-public-rt5" {
  subnet_id = "${aws_subnet.public-subnet5.id}"
  route_table_id = "${aws_route_table.web-public-rt.id}"
}

# Assign the route table to the public Subnet6
resource "aws_route_table_association" "web-public-rt6" {
  subnet_id = "${aws_subnet.public-subnet6.id}"
  route_table_id = "${aws_route_table.web-public-rt.id}"
}
