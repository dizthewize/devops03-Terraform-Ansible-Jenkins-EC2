variable region {
  default = "us-west-1"
}
variable vpc_cidr_block {
  default = "10.0.0.0/16"
}
variable subnet_cidr_block {
  default = "10.0.10.0/24"
}
variable avail_zone {
  default = "us-west-1a"
}
variable env_prefix {
  default = "dev"
}

variable instance_type {
  default = "t2.micro"
}

variable my_ip {
  default = "76.20.91.148/32"
}
variable image_name {
  default = "amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"
}
variable private_key_location {
  default = "~/.ssh/id_rsa"
}
