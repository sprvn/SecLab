module "openstack" {
  source = "./modules/os"

  external_network_id   = var.external_network_id
}

