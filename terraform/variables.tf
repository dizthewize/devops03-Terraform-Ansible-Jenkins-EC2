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
  default = "t2.micro"
}

variable instance_type {
  default = "t2.micro"
}

variable my_ip {
  default = "76.20.91.148/32"
}
variable ssh_key {}
variable image_name {}
variable bucket_name {}
