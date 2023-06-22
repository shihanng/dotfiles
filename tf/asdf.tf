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
    ansible-lint = {
      git_url  = "https://github.com/amrox/asdf-pyapp.git"
      versions = ["6.13.1"]
    }
    direnv = {
      git_url  = "https://github.com/asdf-community/asdf-direnv.git"
      versions = ["2.32.2"]
    }
    kubectl = {
      git_url  = "https://github.com/asdf-community/asdf-kubectl.git"
      versions = ["1.23.3"]
    }
    neovim = {
      git_url  = "https://github.com/richin13/asdf-neovim"
      versions = ["0.9.0"]
    }
  }
}
