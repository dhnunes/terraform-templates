terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "placeholder"
    token = "placeholder"

    workspaces {
      name = "placeholder"
    }
  }
}
