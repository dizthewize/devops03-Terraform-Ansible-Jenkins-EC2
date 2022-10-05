resource "aws_vpc" "myapp-vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = true
  tags = {
    Name: "${var.env_prefix}-vpc"
  }
}

module "myapp-subnet" {
  source = "./modules/subnet"
  subnet_cidr_block = var.subnet_cidr_block
  avail_zone = var.avail_zone
  env_prefix = var.env_prefix
  vpc_id = aws_vpc.myapp-vpc.id
  default_route_table_id = aws_vpc.myapp-vpc.default_route_table_id
}

module "myapp-webserver" {
  source = "./modules/webserver"
  subnet_id = module.myapp-subnet.subnet.id
  vpc_id = aws_vpc.myapp-vpc.id
  my_ip = var.my_ip
  avail_zone = var.avail_zone
  env_prefix = var.env_prefix
  ssh_key = var.ssh_key
  instance_type = var.instance_type
  image_name = var.image_name
}

resource "null_resource" "configure_server" {
  triggers = {
    trigger = module.myapp-webserver.myapp-server.public_ip
  }

  provisioner "local-exec" {
    working_dir = "/Users/martezconner/Desktop/projects/devops/devops03-Terraform-Ansible-GitlabCi-EC2/ansible"
    command = "ansible-playbook -i inventory_aws_ec2.yaml deploy-docker-newuser.yaml"
  }
}
