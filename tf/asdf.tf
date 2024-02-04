terraform {
  required_version = "~> 1.4.6"
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
    direnv = {
      git_url  = "https://github.com/asdf-community/asdf-direnv.git"
      versions = ["2.32.2"]
    }
    kubectl = {
      git_url  = "https://github.com/asdf-community/asdf-kubectl.git"
      versions = ["1.23.3"]
    }
  }
}
