##############################################################################
#   
############################################################################## 
data "openstack_images_image_v2" "ubuntu2204" {
  name        = "ubuntu-22.04-jammy-server-amd64"  #"Fedora-CoreOS-40"
  most_recent = true 
}

 resource "openstack_compute_keypair_v2" "k8pair" {
   name = var.keypair_name
 }


resource "local_file" "k8_server_ssh_rsa_pubkey" {
  content         = openstack_compute_keypair_v2.k8pair.public_key
  filename        = "datacentric_k8s_key_pubkey.pem"
  file_permission = "0600"
}

resource "local_file" "k8_server_ssh_rsa_prikey" {
  content         = openstack_compute_keypair_v2.k8pair.private_key
  filename        = "datacentric_k8s_key_prikey.pem"
  file_permission = "0600"
}

resource "openstack_objectstorage_container_v1" "dns" {
  name   = "datacentric_dns"
  content_type = "text/plain"
  container_read = "admin:admin"
}

resource "openstack_networking_port_v2" "coredns" {
  count          = 1
  name           = "coredns-${count.index + 1}"
  network_id     = "a0fd76a8-5a65-46e1-9579-7221276cd321" #module.reference_infra.networks.internal.id
  security_group_ids = ["01b563a8-48e8-43e8-88e4-177bf612a1df","34938fd3-96b9-417b-81d6-2248c9ecceb6"]
  admin_state_up = true
}

module "dns_servers" {
  source = "./modules/openstack-coredns"
  image_id = data.openstack_images_image_v2.ubuntu2204.id
  flavor_id = var.flavor_id
  network_ports = openstack_networking_port_v2.coredns  
  keypair_name = openstack_compute_keypair_v2.k8pair.name #var.keypair_name
  container_info = {
    name = openstack_objectstorage_container_v1.dns.name
    os_auth_url = var.openstack_api_url
    os_region_name = "RegionOne"
    os_app_id = "admin"
    os_app_secret = var.openstack_adm_pwd
  }
}

module "external_domain" {
  source = "./modules/openstack-zonefile"
  domain = "mydomain.com"
  container = openstack_objectstorage_container_v1.dns.name
  a_records = [
    {
      prefix = "dev"
      ip = "172.17.250.175" #openstack_networking_floatingip_v2.edge_reverse_proxy_floating_ip.address
    }
  ]
}