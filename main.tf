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
resource "ec2_instance" "terraform_rjnoordec2_instance" {
  ami           = "ami-0c94855ba95c71c99"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.terraform_subnet.id
tags={
    Name= "Rj-terraform-ec2-instance"
}
}   resource "aws_subnet" "terraform_private_subnet" {
  vpc_id     = aws_vpc.terraform_vpc.id
  cidr_block = "10.0.2.0/24"
tags={
    Name= "Rj-terraform-private-subnet"
}
}   
resource "aws_ec2_instance" "terraform_private_ec2_instance" {
  ami           = "ami-0c94855ba95c71c99"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.terraform_private_subnet.id
tags={
    Name= "Rj-terraform-private-ec2-instance"
}
}   
resource "s3_bucket" "terraform_s3_bucket" {
  bucket = "rj-terraform-s3-bucket"
  acl    = "private"    
tags={
    Name= "Rjnoord-tf-s3-bucket"    
}
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
s3_bucket_object "terraform_s3_object" {
  bucket = aws_s3_bucket.terraform_s3_bucket.id
  key    = "example.txt"
  content = "https://github.com/Rjnoord/terraform-lab-01/blob/main/Screenshot%202026-06-01%20at%204.23.13%E2%80%AFPM.png
."
}
resource "iam_user" "Damian Lillard" {
  name = "Damian Lillard"
}
iam_role "terraform_iam_role" {
  name = "rj-terraform-iam-role"
  assume_role_policy = jsonencode({{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AIDevOpsAgentSpaceAccess",
            "Effect": "Allow",
            "Action": [
                "aidevops:CreateAgentSpace",
                "aidevops:DeleteAgentSpace",
                "aidevops:GetAgentSpace",
                "aidevops:ListAgentSpaces",
                "aidevops:UpdateAgentSpace"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AIDevOpsServiceAccess",
            "Effect": "Allow",
            "Action": [
                "aidevops:DeregisterService",
                "aidevops:GetService",
                "aidevops:ListServices",
                "aidevops:RegisterService",
                "aidevops:SearchServiceAccessibleResource"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AIDevOpsAssociationAccess",
            "Effect": "Allow",
            "Action": [
                "aidevops:AssociateService",
                "aidevops:DisassociateService",
                "aidevops:GetAssociation",
                "aidevops:ListAssociations",
                "aidevops:UpdateAssociation",
                "aidevops:ValidateAwsAssociations"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AIDevOpsWebhookAccess",
            "Effect": "Allow",
            "Action": [
                "aidevops:ListWebhooks"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AIDevOpsOperatorAppAccess",
            "Effect": "Allow",
            "Action": [
                "aidevops:DisableOperatorApp",
                "aidevops:EnableOperatorApp",
                "aidevops:GetOperatorApp",
                "aidevops:UpdateOperatorAppIdpConfig"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AIDevOpsKnowledgeAccess",
            "Effect": "Allow",
            "Action": [
                "aidevops:CreateKnowledgeItem",
                "aidevops:DeleteKnowledgeItem",
                "aidevops:GetKnowledgeItem",
                "aidevops:ListKnowledgeItems",
                "aidevops:ListKnowledgeItemVersions",
                "aidevops:UpdateKnowledgeItem"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AIDevOpsBacklogAccess",
            "Effect": "Allow",
            "Action": [
                "aidevops:CreateBacklogTask",
                "aidevops:GetBacklogTask",
                "aidevops:ListBacklogTasks",
                "aidevops:ListGoals",
                "aidevops:UpdateBacklogTask",
                "aidevops:UpdateGoal"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AIDevOpsRecommendationAccess",
            "Effect": "Allow",
            "Action": [
                "aidevops:GetRecommendation",
                "aidevops:ListRecommendations",
                "aidevops:UpdateRecommendation"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AIDevOpsAgentChatAccess",
            "Effect": "Allow",
            "Action": [
                "aidevops:CreateChat",
                "aidevops:ListChats",
                "aidevops:ListPendingMessages",
                "aidevops:SendMessage"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AIDevOpsJournalAccess",
            "Effect": "Allow",
            "Action": [
                "aidevops:ListExecutions",
                "aidevops:ListJournalRecords"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AIDevOpsTopologyAccess",
            "Effect": "Allow",
            "Action": [
                "aidevops:DiscoverTopology"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AIDevOpsSupportAccess",
            "Effect": "Allow",
            "Action": [
                "aidevops:DescribeServices",
                "aidevops:DescribeSupportLevel",
                "aidevops:EndChatForCase",
                "aidevops:InitiateChatForCase"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AIDevOpsUsageAccess",
            "Effect": "Allow",
            "Action": [
                "aidevops:GetAccountUsage"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AIDevOpsTaggingAccess",
            "Effect": "Allow",
            "Action": [
                "aidevops:ListTagsForResource",
                "aidevops:TagResource",
                "aidevops:UntagResource"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AIDevOpsVendedLogs",
            "Effect": "Allow",
            "Action": [
                "aidevops:AllowVendedLogDeliveryForResource"
            ],
            "Resource": "*"
        }
    ]
})  
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  }