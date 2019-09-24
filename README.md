#### Infrastructure components
	1. 1 VPC with 10.0.0.0/24 CIDR
	2. 6 public subnets & 6 private subnets
	3. 1 ELB for golang app
	4. 3 golang EC2 Instances in private subnets with identical AZ
	5. 1 Ansible server in private subnet
	6. 1 EC2 instance in public subnet to access all resources in private subnets 
	
#### Ansible
	1. All prerequisite setup by Terraform
	2. Created a passwordless connection with all golang server
	3. Created a Ansible playbook(ansible.yaml) for configure and deploment golang app
#### ELB 
	http://foobar-terraform-elb-540723895.us-east-1.elb.amazonaws.com/

#### DNS
	http://tenermint.redmonkey.in/

#### 	 
