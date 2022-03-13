locals {
  common_apps = [
    "most",
  ]
}

output "common_apps" {
  value = local.common_apps
}
