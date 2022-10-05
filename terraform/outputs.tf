output "ec2_public_ip" {
  value = [
    module.myapp-webserver.myapp-server.public_ip,
  ]
}
