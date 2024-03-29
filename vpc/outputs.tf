output "vpc_id" {
  value = ibm_is_vpc.vpc.id
}

output "frontend_subnet_id" {
  value = ibm_is_subnet.frontend_subnet.id
}

output "backend_subnet_id" {
  value = ibm_is_subnet.backend_subnet.id
}

output "vpc_crn" {
  value = ibm_is_vpc.vpc.crn
}

output "vpc_default_sg" {
  value = ibm_is_vpc.vpc.default_security_group
}

output "vpc" {
  value = ibm_is_vpc.vpc
}

output "resource_group_id" {
  value = data.ibm_resource_group.group.id
}

output "ssh_key_id" {
  value = data.ibm_is_ssh_key.regional.id
}

output "bastion_maintenance_group_id" {
  value = module.bastion.bastion_maintenance_group_id
}

output "bastion_public_ip" {
  value = module.bastion.bastion_public_ip
}

output "deployment_zone" {
  value = data.ibm_is_zones.region.zones[0]
}