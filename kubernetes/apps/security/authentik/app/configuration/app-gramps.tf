resource "authentik_group" "gramps-group" {
  name         = "gramps"
  is_superuser = false
}

resource "authentik_provider_proxy" "gramps-provider" {
  name                = "Gramps"
  external_host       = data.sops_file.secrets.data["gramps_endpoint"]
  authorization_flow  = data.authentik_flow.default-provider-authorization-implicit-consent.id
  invalidation_flow   = data.authentik_flow.default-provider-invalidation-flow.id
  authentication_flow = authentik_flow.passwordless-flow.uuid

  mode               = "forward_single"

  access_token_validity  = "minutes=10"
  refresh_token_validity = "days=2"
}

resource "authentik_application" "gramps-app" {
  name              = "Gramps"
  slug              = "gramps"
  protocol_provider = authentik_provider_proxy.gramps-provider.id
  open_in_new_tab   = true
  meta_icon         = "https://raw.githubusercontent.com/gramps-project/gramps-web/refs/heads/main/images/icon192.png"
  meta_launch_url   = data.sops_file.secrets.data["gramps_endpoint"]
}

resource "authentik_policy_binding" "gramps-app-policy-binding" {
  target         = authentik_application.gramps-app.uuid
  order          = 0

  enabled        = true

  group          = authentik_group.gramps-group.id
  negate         = false
  failure_result = false
}
