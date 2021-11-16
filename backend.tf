terraform {
  backend "s3" {
    bucket         = "terraform-statefiles20200227101306170000000001"
    region         = "eu-west-1" # Do not change region here!
    key            = "sandbox/eks.tfstate"
    dynamodb_table = "terraform-state-lock"
  }
}