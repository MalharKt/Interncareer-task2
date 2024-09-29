variable "aws_access_key" {
  description = "AWS access key"
  type        = string
  default     = "your access key"
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
  default     = "your secret key"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "Availability zone for the subnet"
  type        = string
  default     = "us-east-2a"
}

variable "instance_ami" {
  description = "AMI for the EC2 instance"
  type        = string
  default     = "ami-085f9c64a9b75eed5"
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Key pair for EC2 instance"
  type        = string
  default     = "test-key"
}

variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
  default     = "task2-bucket"
}
