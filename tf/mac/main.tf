locals {
  apps = [
    "git",
    "git-crypt",
    "jq",
    "ripgrep",
    "starship",
    "tmux",
  ]
}

resource "installer_brew" "this" {
  for_each = toset(local.apps)
  name     = each.key
}
