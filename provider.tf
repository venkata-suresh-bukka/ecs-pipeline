
terraform {
  backend "s3" {
    bucket         = "store-statefiles"         # Replace with your actual S3 bucket name
    key            = "terraform.tfstate"        # Path to the state file in S3
    region         = "us-east-1"                # AWS Region where S3 is hosted
    encrypt        = true                       # Enables server-side encryption
    # dynamodb_table = "terraform-locks"         # (Optional) DynamoDB for state locking
  }
}
provider "aws" {
  region = var.aws_region
}


