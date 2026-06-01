provider "aws" {
  region = "us-east-1"
}
resource "aws_vpc" "terraform_vpc" {
  cidr_block = "10.0.0.0/16"

tags={
 Name= "Rj-terraform-vpc"
}
}