provider "aws" {
  region = "us-east-1"
}
resource "aws_vpc" "terraform_vpc" {
  cidr_block = "10.0.0.0/16"

tags={
 Name= "Rj-terraform-vpc"
}
}
resource "aws_subnet" "terraform_subnet" {
  vpc_id     = aws_vpc.terraform_vpc.id
  cidr_block = "10.0.1.0/24"
tags={
    Name= "Rj-terraform-subnet"
}
}
resource "aws_internet_gateway" "terraform_igw" {
    vpc_id = aws_vpc.terraform_vpc.id
tags={
    Name= "Rj-terraform-igw"
}

}
resource "aws_route_table" "terraform_route_table" {
    vpc_id = aws_vpc.terraform_vpc.id
tags={
    Name= "Rj-terraform-route-table"
}
}
resource "aws_instance" "terraform_rjnoordec2_instance" {
  ami           = "ami-0c94855ba95c71c99"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.terraform_subnet.id
tags={
    Name= "Rj-terraform-ec2-instance"
}
}

resource "aws_subnet" "terraform_private_subnet" {
  vpc_id     = aws_vpc.terraform_vpc.id
  cidr_block = "10.0.2.0/24"
tags={
    Name= "Rj-terraform-private-subnet"
}
}   
resource "aws_instance" "terraform_private_ec2_instance" {
  ami           = "ami-0c94855ba95c71c99"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.terraform_private_subnet.id
tags={
    Name= "Rj-terraform-private-ec2-instance"
}
}   
resource "aws_s3_bucket" "terraform_s3_bucket" {
  bucket = "rj-terraform-s3-bucket"
  acl    = "private"

  tags = {
    Name = "Rjnoord-tf-s3-bucket"
  }
}
resource "aws_s3_object" "terraform_s3_object" {
  bucket  = aws_s3_bucket.terraform_s3_bucket.id
  key     = "example.txt"
  content = "https://github.com/Rjnoord/terraform-lab-01/blob/main/Screenshot%202026-06-01%20at%204.23.13%E2%80%AFPM.png"
}
resource "aws_security_group" "terraform_security_group" {
  name        = "rj-terraform-security-group"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = aws_vpc.terraform_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_iam_user" "Damian_Lillard" {
  name = "Damian_Lillard"
}
resource "aws_iam_role" "terraform_iam_role" {
  name = "rj-terraform-iam-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = { Service = "ec2.amazonaws.com" }
      }
    ]
  })
}