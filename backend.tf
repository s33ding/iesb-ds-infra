terraform {
  backend "s3" {
    bucket         = "iesb-terraformbucket"
    key            = "myapp/state.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}
