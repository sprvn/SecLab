terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "1.32.0"
    }
  }
}

provider "openstack" {
  alias = "seclab_os_provider"
  user_name = "seclab_os_user"
  password = random_password.kali_lab_os_password.result
  tenant_name = openstack_identity_project_v3.kali_lab.name
}
