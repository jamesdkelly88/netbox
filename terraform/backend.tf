terraform {

  cloud {
    organization = "jdkhomelab-netbox"
    hostname     = "app.terraform.io"
    workspaces {
      name = "netbox"
    }
  }

  required_version = "~> 1.9"
}