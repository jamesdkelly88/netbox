resource "netbox_cluster_type" "type" {
  for_each = { for type in local.clusters : type.type => type }
  name     = each.key
}

resource "netbox_cluster" "cluster" {
  for_each = {
    for combination in flatten([
      for type in local.clusters : [
        for cluster in type.names : {
          key     = cluster
          type    = type.type
          cluster = cluster
        }
      ]
    ]) :
    combination.key => combination
  }

  name            = each.value.cluster
  cluster_type_id = netbox_cluster_type.type[each.value.type].id
  depends_on      = [netbox_cluster_type.type]
}