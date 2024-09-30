terraform {
  backend "s3" {
    bucket         = "demoer"  
    key            = "terraform.tfstate"        
    region         = "us-east-2"                          
  }
}
