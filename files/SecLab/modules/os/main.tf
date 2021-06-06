resource "random_password" "seclab_os_password" {
  length = 64
}

resource "openstack_identity_project_v3" "seclab" {
  name        = "SecLab"
  description = "Lab project used to learn security conecpts, methods and techniques"
}

resource "openstack_identity_user_v3" "seclab_os_user" {
  default_project_id = openstack_identity_project_v3.seclab.id
  name               = "seclab"
  description        = "SecLab administrator user"

  password = random_password.seclab_os_password.result
  ignore_change_password_upon_first_use = true # Don't have to change for our lab purposes
}

resource "openstack_identity_role_v3" "seclab_role" {
  name = "seclab_role"
}

resource "openstack_identity_role_assignment_v3" "seclab_role_assignment" {
  user_id    = openstack_identity_user_v3.seclab_os_user.id
  project_id = openstack_identity_project_v3.seclab.id
  role_id    = openstack_identity_role_v3.seclab_role.id
}

# The main router of the lab
resource "openstack_networking_router_v2" "seclab_router" {
  name                = "SecLab router"
  tenant_id           = openstack_identity_project_v3.seclab.id
  admin_state_up      = true
  enable_snat         = true
  external_network_id = var.external_network_id # Configured during the Openstack installation/configuration and must be provided
}

