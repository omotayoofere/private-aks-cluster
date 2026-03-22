data "terraform_remote_state" "base" {
  backend = "local"

  config = {
    path = "../base/terraform.tfstate"
  }
}

data "terraform_remote_state" "rg" {
  backend = "local"

  config = {
    path = "../rg/terraform.tfstate"
  }
}
