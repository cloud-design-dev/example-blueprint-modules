resource "ibm_resource_instance" "monitoring" {
  name              = "${var.name}-monitoring-instance"
  service           = "sysdig-monitor"
  plan              = "graduated-tier"
  location          = var.vpc_region
  resource_group_id = var.resource_group_id
  tags              = ["ryantiffany", "sysdig"]
}