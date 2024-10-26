resource "authentik_group" "new-user-group" {
  name         = "invitation-users"
  is_superuser = false
}
