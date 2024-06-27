##############################################################################
#   
############################################################################## 
data "openstack_images_image_v2" "ubuntu2204" {
  name        = "ubuntu-22.04-jammy-server-amd64"  #"Fedora-CoreOS-40"
  most_recent = true 
}

resource "openstack_objectstorage_container_v1" "dns" {
  name   = "dns"
  content_type = "text/plain"
  container_read = "admin:admin"
}

resource "openstack_networking_port_v2" "coredns" {
  count          = 1
  name           = "coredns-${count.index + 1}"
  network_id     = "a0fd76a8-5a65-46e1-9579-7221276cd321" #module.reference_infra.networks.internal.id
  security_group_ids = ["01b563a8-48e8-43e8-88e4-177bf612a1df"]
  admin_state_up = true
}

module "dns_servers" {
  source = "./modules/openstack-coredns"
  
}

module "external_domain" {
  source = "./modules/openstack-zonefile"
 