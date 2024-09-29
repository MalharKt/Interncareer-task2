terraform {
  backend "s3" {
    bucket    = "task2-bucket"
    key       = "terraform.tfstate"
    region    = "us-east-2"
    access_key = "your access key"
    secret_key = "your secret key"
  }
}
