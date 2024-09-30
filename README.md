Hosting a Website on S3 with Terraform
This guide explains how to host a static website using Amazon S3 and automate the infrastructure setup using Terraform.

Prerequisites
An AWS account
Basic knowledge of AWS services (EC2, S3, IAM)
Familiarity with Terraform

Step 1: Launch EC2 Instance :

Launch an EC2 instance with the following configuration:
• Instance Type: t2.micro
• Enabled Ports: 443, 22, 80 
• Storage: At least 10 GB 
SSH into the instance using the key pair.

Step 2: Install Dependencies : 

• Install Terraform 
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
sudo apt update
sudo apt-get install terraform -y

• Create IAM user and attach the following policies 
ec2fullaccess
s3fullaccess
vpcfullacces
ec2instanceconnect
s3accesspolicy

Step3: Write tf script
• write required tf files
• terraform init
• terraform plan
• terraform apply

IMPORTANT NOTE : Remember to destroy resources when no longer needed to avoid unnecessary charges. Make use of the below command
• terraform destroy

Congrats.. Your website is hosted with automation 😊


