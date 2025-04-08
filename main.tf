provider "aws" {
  region = var.aws_region
}

data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "vpc" {
  source  = "./vpc"
  vpc_cidr = "10.0.0.0/16"
}

module "subnet" {
  source  = "./subnets"
  vpc_id  = module.vpc.vpc_id
  public_cidr_az1  = "10.0.1.0/24"
  public_cidr_az2  = "10.0.2.0/24"
  private_cidr_az1 = "10.0.3.0/24"
  private_cidr_az2 = "10.0.4.0/24"
  az1 = "us-east-1a"
  az2 = "us-east-1b"
}

module "gateways" {
  source  = "./gateways"
  vpc_id  = module.vpc.vpc_id
  public_subnet_az1_id = module.subnet.public_subnet_az1_id
}

module "routes" {
  source  = "./routes"
  vpc_id  = module.vpc.vpc_id
  igw_id  = module.gateways.igw_id
  nat_gw_id = module.gateways.nat_gw_id
  public_subnet_az1_id = module.subnet.public_subnet_az1_id
  public_subnet_az2_id = module.subnet.public_subnet_az2_id
  private_subnet_az1_id = module.subnet.private_subnet_az1_id
  private_subnet_az2_id = module.subnet.private_subnet_az2_id
}

module "security_groups" {
  source  = "./security-groups"
  vpc_id  = module.vpc.vpc_id
}

module "loadbalancer" {
  source  = "./loadbalancer"
  vpc_id  = module.vpc.vpc_id
  public_sg_id  = module.security_groups.public_sg_id
  private_sg_id = module.security_groups.private_sg_id
  public_subnet_az1_id = module.subnet.public_subnet_az1_id
  public_subnet_az2_id = module.subnet.public_subnet_az2_id
  private_subnet_az1_id = module.subnet.private_subnet_az1_id
  private_subnet_az2_id = module.subnet.private_subnet_az2_id
}

module "instances" {
  source  = "./instances"
  ami_id = data.aws_ami.latest_amazon_linux.id

  public_subnet_az1_id = module.subnet.public_subnet_az1_id
  public_subnet_az2_id = module.subnet.public_subnet_az2_id
  private_subnet_az1_id = module.subnet.private_subnet_az1_id
  private_subnet_az2_id = module.subnet.private_subnet_az2_id

  public_sg_id = module.security_groups.public_sg_id
  private_sg_id = module.security_groups.private_sg_id

  public_tg_arn = module.loadbalancer.public_tg_arn
  private_tg_arn = module.loadbalancer.private_tg_arn
}
output "vpc_id" {
  value = module.vpc.vpc_id
}
output "public_alb_dns" {
  value = module.loadbalancer.public_alb_dns
}
output "proxy_az1_public_ip" {
  value = module.instances.proxy_az1_public_ip
}

output "proxy_az2_public_ip" {
  value = module.instances.proxy_az2_public_ip
}

output "backend_az1_private_ip" {
  value = module.instances.backend_az1_private_ip
}

output "backend_az2_private_ip" {
  value = module.instances.backend_az2_private_ip
}
