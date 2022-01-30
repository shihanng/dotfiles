config {
  module              = true
  force               = false
  disabled_by_default = false
}

rule "terraform_comment_syntax" {
  enabled = true
}

rule "terraform_naming_convention" {
  enabled = true
}

plugin "aws" {
  enabled = true
}
