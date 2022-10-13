output "ec2_public_ip" {
  value = "${module.myapp-webserver.myapp-server.public_ip}"
}

output "ec2_id" {
  value = "${module.myapp-webserver.myapp-server.id}"
}
