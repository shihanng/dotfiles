locals {
  apps = {
    direnv = "2.28.0"
  }
}

resource "installer_asdf_plugin" "this" {
  for_each = local.apps
  name     = each.key
}

resource "installer_asdf" "this" {
  for_each = local.apps
  name     = each.key
  version  = each.value

  depends_on = [
    installer_asdf_plugin.this,
  ]
}
