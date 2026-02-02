terraform {
  backend "s3" {
    bucket = "terra-test022025"
    key    = "terraform/tfstate.tfstate"
    region = "us-east-2"
    profile = "terra_test"
  }
}