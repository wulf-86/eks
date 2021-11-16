data "terraform_remote_state" "sg" {
  backend = "s3"

  config = {
    bucket         = "terraform-statefiles20200227101306170000000001"
    region         = "eu-west-1" # Do not change region here!
    key            = "${local.env_index}/sg.tfstate"
    dynamodb_table = "terraform-state-lock"
  }
}