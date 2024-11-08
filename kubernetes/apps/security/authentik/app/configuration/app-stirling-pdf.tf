resource "authentik_group" "stirling-group" {
  name         = "stirling-pdf"
  is_superuser = false
}

resource "authentik_provider_proxy" "stirling-provider" {
  name                = "Stirling-PDF"
  external_host       = data.sops_file.secrets.data["stirling_endpoint"]
  authorization_flow  = data.authentik_flow.default-provider-authorization-implicit-consent.id
  invalidation_flow   = data.authentik_flow.default-provider-invalidation-flow.id
  authentication_flow = authentik_flow.passwordless-flow.uuid

  mode               = "forward_single"

  access_token_validity  = "minutes=10"
  refresh_token_validity = "days=2"
}

resource "authentik_application" "stirling-app" {
  name              = "Stirling-PDF"
  slug              = "stirling-pdf"
  protocol_provider = authentik_provider_proxy.stirling-provider.id
  open_in_new_tab   = true
  meta_icon         = "https://raw.githubusercontent.com/Stirling-Tools/Stirling-PDF/main/docs/stirling.png"
  meta_launch_url   = data.sops_file.secrets.data["stirling_endpoint"]
}

resource "authentik_policy_binding" "stirling-app-policy-binding" {
  target         = authentik_application.stirling-app.uuid
  order          = 0

  enabled        = true

  group          = authentik_group.stirling-group.id
  negate         = false
  failure_result = false
}
