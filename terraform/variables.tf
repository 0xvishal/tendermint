variable "aws_region" {
  description = "Region for the VPC"
  default = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default = "10.0.0.0/24"
}

variable "public_subnet_cidr1" {
  description = "CIDR for the public subnet"
  default = "10.0.0.0/27"
}

variable "public_subnet_cidr2" {
  description = "CIDR for the public subnet"
  default = "10.0.0.32/27"
}

variable "public_subnet_cidr3" {
  description = "CIDR for the public subnet"
  default = "10.0.0.64/28"
}

variable "public_subnet_cidr4" {
  description = "CIDR for the public subnet"
  default = "10.0.0.80/28"
}

variable "public_subnet_cidr5" {
  description = "CIDR for the public subnet"
  default = "10.0.0.96/28"
}

variable "public_subnet_cidr6" {
  description = "CIDR for the public subnet"
  default = "10.0.0.112/28"
}




variable "private_subnet_cidr1" {
  description = "CIDR for the private subnet"
  default = "10.0.0.128/27"
}

variable "private_subnet_cidr2" {
  description = "CIDR for the private subnet"
  default = "10.0.0.160/27"
}

variable "private_subnet_cidr3" {
  description = "CIDR for the private subnet"
  default = "10.0.0.192/28"
}

variable "private_subnet_cidr4" {
  description = "CIDR for the private subnet"
  default = "10.0.0.208/28"
}

variable "private_subnet_cidr5" {
  description = "CIDR for the private subnet"
  default = "10.0.0.224/28"
}

variable "private_subnet_cidr6" {
  description = "CIDR for the private subnet"
  default = "10.0.0.240/28"
}

variable "ami" {
  description = "AMI for EC2"
  # default = "ami-0036ab7a"
   default = "ami-0f9cf087c1f27d9b1"
}
