locals {
  apps = ["git", "starship", "ripgrep", "tmux", "jq"]
}

resource "installer_brew" "this" {
  for_each = toset(local.apps)
  name     = each.key
}
