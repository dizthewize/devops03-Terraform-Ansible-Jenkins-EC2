output "ec2_public_ip" {
  value = [
    module.myapp-webserver.myapp-server.public_ip,
  ]
}

output "s3_bucket_domain_name" {
    value = [
      module.myapp-s3bucket.terraform-state
    ]
}
