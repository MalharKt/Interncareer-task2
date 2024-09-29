output "vpc_id" {
  value = aws_vpc.app_vpc.id
}

output "subnet_id" {
  value = aws_subnet.public_sub.id
}

output "instance_id" {
  value = aws_instance.machine1.id
}

output "s3_bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket
}

output "security_group_id" {
  value = aws_security_group.test_sg.id
}