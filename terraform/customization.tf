resource "netbox_custom_field_choice_set" "choices" {
  for_each      = tomap(local.choice_lists)
  name          = each.key
  extra_choices = each.value
}

resource "netbox_custom_field" "field" {
  for_each         = { for field in local.custom_fields : field.name => field }
  default          = each.value.required == true ? each.value.default : null
  name             = lower(replace(each.value.name, " ", "_"))
  label            = each.value.name
  description      = each.value.description
  required         = each.value.required
  type             = each.value.type
  content_types    = each.value.classes
  weight           = 100
  validation_regex = each.value.type == "text" ? each.value.regex : null
  choice_set_id    = each.value.choices == null ? null : netbox_custom_field_choice_set.choices[each.value.choices].id
}