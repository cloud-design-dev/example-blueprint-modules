output "vpc_id" {
  value = ibm_is_vpc.vpc.id
}

output "zone_1_subnet_id" {
  value = ibm_is_subnet.subnet.0.id
}


output "subnet_ids" {
  value = ibm_is_subnet.subnet.*.id
}

output "vpc_crn" {
  value = ibm_is_vpc.vpc.crn
}
