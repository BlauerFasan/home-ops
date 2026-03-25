resource "authentik_group" "bento-group" {
  name         = "bento-pdf"
  is_superuser = false
}

resource "authentik_provider_proxy" "bento-provider" {
  name                = "bento-PDF"
  external_host       = data.sops_file.secrets.data["bento_endpoint"]
  authorization_flow  = data.authentik_flow.default-provider-authorization-implicit-consent.id
  invalidation_flow   = data.authentik_flow.default-provider-invalidation-flow.id
  authentication_flow = authentik_flow.passwordless-flow.uuid

  mode               = "forward_single"

  access_token_validity  = "minutes=10"
  refresh_token_validity = "days=2"
}

resource "authentik_application" "bento-app" {
  name              = "bento-PDF"
  slug              = "bento-pdf"
  protocol_provider = authentik_provider_proxy.bento-provider.id
  open_in_new_tab   = true
  meta_icon         = ""
  meta_launch_url   = data.sops_file.secrets.data["bento_endpoint"]
}

resource "authentik_policy_binding" "bento-app-policy-binding" {
  target         = authentik_application.bento-app.uuid
  order          = 0

  enabled        = true

  group          = authentik_group.bento-group.id
  negate         = false
  failure_result = false
}
