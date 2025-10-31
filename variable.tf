variable "ENVIRONMENT" {
  description = "AWS region to deploy resources"
  default = "us-east-1"
}

variable "REGION" {
  description = "Deployment environment"
  default = "dev"
}

variable "INSTANCE_TYPE" {
  description = "Ec2 instance type"
  default = "t2.micro"
}