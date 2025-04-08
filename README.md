# AWS Terraform Project

## Project Overview
This Terraform project sets up an AWS infrastructure with:
- A VPC with public and private subnets.
- Internet Gateway for public access and NAT Gateway for private instances.
- Two Elastic Load Balancers (ELB) for public and private EC2 instances.
- EC2 instances with Apache installed.
- Security Groups for controlled access.

## Project Structure
```
project-folder/
│-- elb-m/                # Load Balancers configuration
│-- gateways-m/           # Internet Gateway & NAT Gateway
│-- instance-m/           # EC2 instances and provisioning
│-- project pics/         # Project-related images
│-- routes-m/             # Route Tables configuration
│-- s3-statefile/         # Terraform state storage (S3 backend)
│-- SecurityGroups-m/     # Security Groups for instances and ELBs
│-- subnet-m/             # Subnets definitions (Public & Private)
│-- vpc-m/                # VPC configuration
│-- main.tf               # Main Terraform configuration file
│-- outputs.tf            # Output values (ELB DNS, instance IPs, etc.)
│-- provider.tf           # AWS Provider setup
```

## Setup & Deployment
### Prerequisites
Ensure you have the following installed:
- Terraform
- AWS CLI
- Git (if using version control)

### Steps to Deploy
1. **Initialize Terraform:**
   ```sh
   terraform init
   ```
2. **Plan the Deployment:**
   ```sh
   terraform plan
   ```
3. **Apply the Configuration:**
   ```sh
   terraform apply -auto-approve
   ```

### Outputs
After deployment, Terraform will output useful details, including:
- Public ALB DNS
- Private ALB DNS
- Public and private EC2 instance IPs

### Testing the Setup
- Access the public Load Balancer via browser or `curl`:
  ```sh
  curl http://<public-alb-dns>
  ```
- For private ALB, you may need a bastion host or VPN access.
- or from ssh the public ec2 and curl from it 

## Cleanup
To destroy the infrastructure:
```sh
terraform destroy -auto-approve
```

## Notes
- AMIs are dynamically selected using Terraform data sources.
- The Apache server is installed on EC2 instances via remote provisioners.
- NAT Gateway allows private instances to access the internet for updates.

### Author
This Terraform project was created to automate AWS resource provisioning. Contributions and improvements are welcome!

