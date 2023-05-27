terraform {
  required_providers {
    installer = {
      source  = "shihanng/installer"
      version = "0.6.0"
    }
  }
}

variable "apps" {
  type = map(
    object({
      git_url  = string
      versions = list(string)
    })
  )
}

locals {
  versions = flatten([
    for app, settings in var.apps : [
      for version in settings.versions : {
        name    = app
        version = version
      }
    ]
  ])
}

resource "installer_asdf_plugin" "this" {
  for_each = var.apps
  name     = each.key
  git_url  = each.value.git_url
}

resource "installer_asdf" "this" {
  for_each = {
    for version in local.versions : version.name => version.version
  }

  name    = each.key
  version = each.value

  depends_on = [
    installer_asdf_plugin.this,
  ]
}

resource "installer_asdf_plugin" "lua" {
  name    = "lua"
  git_url = "https://github.com/Stratus3D/asdf-lua.git"

}

resource "installer_asdf" "lua" {
  name    = "lua"
  version = "5.4.4"
  environment = {
    "ASDF_LUA_LINUX_READLINE" : "1"
  }

  depends_on = [
    installer_asdf_plugin.lua,
  ]
}
