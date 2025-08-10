resource "netbox_manufacturer" "manufacturer" {
  for_each = { for manufacturer in local.manufacturers : manufacturer => manufacturer }
  name     = each.value
}

resource "netbox_device_role" "role" {
  for_each  = { for role in local.roles : role => role }
  name      = each.value
  color_hex = local.colours[index(local.roles, each.value)]
  vm_role   = true

}

resource "netbox_platform" "os" {
  for_each = {
    for combination in flatten([
      for os in local.operating_systems : [
        for version in os.versions : {
          key = trim("${os.name} ${version}", " ")
        }
      ]
    ]) :
    combination.key => combination
  }

  name = each.key
}