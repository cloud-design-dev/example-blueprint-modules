

resource "ibm_is_vpc" "vpc" {
  name           = "${var.name}-vpc"
  resource_group = data.ibm_resource_group.group.id
  tags           = concat(var.tags, ["region:${var.vpc_region}", "vpc:${var.name}-vpc"])
}

resource "ibm_is_public_gateway" "zone_1" {
  name           = "${var.name}-zone-1-pubgw"
  vpc            = ibm_is_vpc.vpc.id
  zone           = data.ibm_is_zones.region.zones[0]
  resource_group = data.ibm_resource_group.group.id
  tags           = concat(var.tags, ["region:${var.vpc_region}", "zone:${data.ibm_is_zones.region.zones[0]}", "vpc:${var.name}-vpc"])
}

resource "ibm_is_subnet" "subnet" {
  count                    = length(data.ibm_is_zones.region.zones)
  name                     = "${var.name}-${data.ibm_is_zones.region.zones[count.index]}-subnet"
  vpc                      = ibm_is_vpc.vpc.id
  zone                     = data.ibm_is_zones.region.zones[count.index]
  total_ipv4_address_count = "64"
  resource_group           = data.ibm_resource_group.group.id
  public_gateway           = ibm_is_public_gateway.zone_1.id
  tags                     = concat(var.tags, ["region:${var.vpc_region}", "zone:${data.ibm_is_zones.region.zones[count.index]}", "vpc:${var.name}-vpc"])
}
