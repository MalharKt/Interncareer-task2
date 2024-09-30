provider "aws" {
  region = "us-east-2" # Change to your preferred region
}

resource "aws_vpc" "portfolio_vpc" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "portfolio_vpc"
  }
  
}



resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.portfolio_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-2a" 
  
  tags = {
    Name = "public subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.portfolio_vpc.id

  tags = {
    Name = "IGW"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.portfolio_vpc.id

  tags = {
    Name = "public rt"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_subnet_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}



resource "aws_instance" "portfolio_instance" {
  ami           = "ami-085f9c64a9b75eed5"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = "project" 

  tags = {
    Name = "task2-instance"
  }
}


resource "aws_s3_bucket" "demo-bucket" {
  bucket = var.my_bucket_name # Name of the S3 bucket
}


resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.demo-bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}


resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.demo-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false 
}


# AWS S3 bucket ACL resource
resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
  ]

  bucket = aws_s3_bucket.demo-bucket.id
  acl    = "public-read"
}



resource "aws_s3_bucket_policy" "host_bucket_policy" {
  bucket =  aws_s3_bucket.demo-bucket.id # ID of the S3 bucket

  # Policy JSON for allowing public read access
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : "s3:GetObject",
        "Resource": "arn:aws:s3:::${var.my_bucket_name}/*"
      }
    ]
  })
}

module "template_files" {
    source = "hashicorp/dir/template"

    base_dir = "${path.module}/web-files"
}

# https://registry.terraform.io/modules/hashicorp/dir/template/latest


resource "aws_s3_bucket_website_configuration" "web-config" {
  bucket =    aws_s3_bucket.demo-bucket.id  # ID of the S3 bucket

  # Configuration for the index document
  index_document {
    suffix = "index.html"
  }
}


# AWS S3 object resource for hosting bucket files
resource "aws_s3_object" "Bucket_files" {
  bucket =  aws_s3_bucket.demo-bucket.id  # ID of the S3 bucket

  for_each     = module.template_files.files
  key          = each.key
  content_type = each.value.content_type

  source  = each.value.source_path
  content = each.value.content

  # ETag of the S3 object
  etag = each.value.digests.md5
}
