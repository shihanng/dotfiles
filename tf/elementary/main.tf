resource "installer_apt" "this" {
  for_each = toset(module.lists.common_apps)
  name     = each.key
}
