# continent (region) -> country (region) -> city (region) -> building/provider (site) -> room/az (location) -> rack 
# need to set dependencies


resource "netbox_region" "continent" {
  for_each    = { for continent in local.regions : continent.name => continent }
  name        = each.value.name
  description = "Continent"
}

resource "netbox_region" "country" {
  for_each = {
    for combination in flatten([
      for continent in local.regions : [
        for country in continent.countries : {
          key       = country.name
          continent = continent.name
          country   = country.name
        }
      ]
    ]) :
    combination.key => combination
  }

  name             = each.value.country
  description      = "Country"
  parent_region_id = netbox_region.continent[each.value.continent].id
  depends_on       = [netbox_region.continent]
}

resource "netbox_region" "city" {
  for_each = {
    for combination in flatten([
      for continent in local.regions : [
        for country in continent.countries : [
          for city in country.cities : {
            key       = city
            continent = continent.name
            country   = country.name
            city      = city
          }
        ]
      ]
    ]) :
    combination.key => combination
  }

  name             = each.value.city
  description      = "City"
  parent_region_id = netbox_region.country[each.value.country].id
  depends_on       = [netbox_region.country]
}

resource "netbox_site" "site" {
  for_each   = { for site in local.sites : site.name => site }
  name       = each.value.name
  region_id  = netbox_region.city[each.value.city].id
  status     = each.value.status
  depends_on = [netbox_region.city]
}

resource "netbox_location" "room" {
  for_each   = { for room in local.rooms : room => room }
  name       = each.value
  site_id    = netbox_site.site["Home"].id
  depends_on = [netbox_site.site]
}

resource "netbox_rack" "rack" {
  for_each    = { for rack in local.racks : rack => rack }
  name        = each.value
  location_id = netbox_location.room["Homelab"].id
  site_id     = netbox_site.site["Home"].id
  status      = "active"
  u_height    = 1
  width       = 19
  depends_on  = [netbox_location.room]
}