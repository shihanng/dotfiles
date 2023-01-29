terraform {
  required_version = "~> 1.3.5"
  backend "local" {
    path = "terraform.tfstate"
  }
}

module "installer" {
  source = "./modules/asdf"
  apps = {
    awscli = {
      git_url  = "https://github.com/MetricMike/asdf-awscli.git"
      versions = ["2.9.17"]
    }
    vault = {
      git_url  = "https://github.com/asdf-community/asdf-hashicorp.git"
      versions = ["1.12.2"]
    }
    pgcli = {
      git_url  = "https://github.com/amrox/asdf-pyapp.git"
      versions = ["3.5.0"]
    }
    tflint = {
      git_url  = "https://github.com/skyzyx/asdf-tflint"
      versions = ["0.44.1"]
    }
    terraform = {
      git_url  = "https://github.com/asdf-community/asdf-hashicorp.git"
      versions = ["1.3.5"]
    }
    terraform-ls = {
      git_url  = "https://github.com/asdf-community/asdf-hashicorp.git"
      versions = ["0.30.1"]
    }
  }
}
