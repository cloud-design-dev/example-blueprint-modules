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

resource "ibm_is_subnet" "frontend_subnet" {
  name                     = "${var.name}-${data.ibm_is_zones.region.zones[0]}-frontend-subnet"
  vpc                      = ibm_is_vpc.vpc.id
  zone                     = data.ibm_is_zones.region.zones[0]
  total_ipv4_address_count = "64"
  resource_group           = data.ibm_resource_group.group.id
  public_gateway           = ibm_is_public_gateway.zone_1.id
  tags                     = concat(var.tags, ["region:${var.vpc_region}", "zone:${data.ibm_is_zones.region.zones[0]}", "vpc:${var.name}-vpc"])
}

resource "ibm_is_subnet" "backend_subnet" {
  name                     = "${var.name}-${data.ibm_is_zones.region.zones[0]}-backend-subnet"
  vpc                      = ibm_is_vpc.vpc.id
  zone                     = data.ibm_is_zones.region.zones[0]
  total_ipv4_address_count = "256"
  resource_group           = data.ibm_resource_group.group.id
  public_gateway           = ibm_is_public_gateway.zone_1.id
  tags                     = concat(var.tags, ["region:${var.vpc_region}", "zone:${data.ibm_is_zones.region.zones[0]}", "vpc:${var.name}-vpc"])
}

module "bastion" {
  source = "we-work-in-the-cloud/vpc-bastion/ibm"

  vpc_id            = ibm_is_vpc.vpc.id
  resource_group_id = data.ibm_resource_group.group.id
  name              = "${var.name}-bastion"
  ssh_key_ids       = [data.ibm_is_ssh_key.regional.id]
  subnet_id         = ibm_is_subnet.frontend_subnet.id
  create_public_ip  = true
  allow_ssh_from    = var.allow_ssh_from
  tags              = concat(var.tags, ["region:${var.vpc_region}", "zone:${data.ibm_is_zones.region.zones[0]}", "vpc:${var.name}-vpc"])
}
