terraform {
  backend "s3" {
    bucket         = "abdrabo-remote-statefile"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-table"
  }
}