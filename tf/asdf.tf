terraform {
  required_version = "~> 1.3.5"
  backend "local" {
    path = "terraform.tfstate"
  }
}

module "installer" {
  source = "./modules/asdf"
  apps = {
    hugo = {
      git_url  = "https://github.com/NeoHsu/asdf-hugo.git"
      versions = ["0.110.0"]
    }
    awscli = {
      git_url  = "https://github.com/MetricMike/asdf-awscli.git"
      versions = ["2.9.17"]
    }
  }
}
