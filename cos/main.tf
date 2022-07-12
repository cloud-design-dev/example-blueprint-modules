resource "ibm_resource_instance" "cos_instance" {
  name              = "${var.name}-cos-instance"
  service           = "cloud-object-storage"
  plan              = "standard"
  location          = "global"
  resource_group_id = data.ibm_resource_group.group.id
  tags              = ["vpc:${var.name}-vpc"]

}


resource "ibm_cos_bucket" "zone_1" {
  bucket_name          = "${var.vpc_region}-1-${var.name}-bucket"
  resource_instance_id = ibm_resource_instance.cos_instance.id
  region_location      = var.vpc_region
  storage_class        = var.cos_storage_class
}