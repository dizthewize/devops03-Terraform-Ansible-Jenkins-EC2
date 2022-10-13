resource "aws_default_security_group" "default-sg" {
  vpc_id = var.vpc_id

  ingress {
    cidr_blocks = [var.my_ip]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 80
    to_port = 80
    protocol = "tcp"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    prefix_list_ids = []
  }

  tags = {
    Name: "${var.env_prefix}-default-sg"
  }
}

data "aws_ami" "lastest-amazon-linux-image" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = [var.image_name]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_key_pair" "jenkins-server" {
  key_name           = "jenkins-server"
  include_public_key = true
}



resource "aws_instance" "myapp-server" {
  ami = data.aws_ami.lastest-amazon-linux-image.id
  instance_type = var.instance_type

  subnet_id = var.subnet_id
  vpc_security_group_ids = [aws_default_security_group.default-sg.id]
  availability_zone = var.avail_zone

  associate_public_ip_address = true

  # use existing key pair
  key_name = data.aws_key_pair.jenkins-server.key_name

  tags = {
    Name = "ec2-${var.env_prefix}-server"
    Environment = "${var.env_prefix}"
  }
}
