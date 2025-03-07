terraform {
  backend "s3" {
    bucket         = "iesb-terraformbucket"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}
