# Configure the OpenStack Provider
provider "openstack" {
  user_name   = "admin"
  tenant_name = "admin"
  password    = var.openstack_adm_pwd
  auth_url    = var.openstack_api_url
  region      = "RegionOne"
}
