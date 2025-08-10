resource "netbox_prefix" "prefix" {
  for_each    = { for prefix in local.prefixes : prefix.name => prefix }
  prefix      = each.value.cidr
  status      = "active"
  description = each.value.name
}

resource "netbox_ipam_role" "range" {
  for_each = { for range in local.ranges : range.name => range }
  name     = each.value.name
}

resource "netbox_ip_range" "range" {
  for_each      = { for range in local.ranges : range.name => range }
  role_id       = netbox_ipam_role.range[each.value.name].id
  start_address = "${local.cidr.prefix}.${local.cidr.subnet + floor(each.value.start / 256)}.${each.value.start % 256}/${local.cidr.mask}"
  end_address   = "${local.cidr.prefix}.${local.cidr.subnet + floor((each.value.start + each.value.size - 1) / 256)}.${(each.value.start + each.value.size - 1) % 256}/${local.cidr.mask}"
  depends_on    = [netbox_ipam_role.range]
}