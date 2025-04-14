resource "authentik_group" "it-tools-group" {
  name         = "it-tools"
  is_superuser = false
}

resource "authentik_provider_proxy" "it-tools-provider" {
  name                = "IT-Tools"
  external_host       = data.sops_file.secrets.data["it-tools_endpoint"]
  authorization_flow  = data.authentik_flow.default-provider-authorization-implicit-consent.id
  invalidation_flow   = data.authentik_flow.default-provider-invalidation-flow.id
  authentication_flow = authentik_flow.passwordless-flow.uuid

  mode               = "forward_single"

  access_token_validity  = "minutes=10"
  refresh_token_validity = "days=2"
}

resource "authentik_application" "it-tools-app" {
  name              = "IT-Tools"
  slug              = "it-tools"
  protocol_provider = authentik_provider_proxy.it-tools-provider.id
  open_in_new_tab   = true
  meta_icon         = "https://raw.githubusercontent.com/Stirling-Tools/Stirling-PDF/main/docs/stirling.png"
  meta_launch_url   = data.sops_file.secrets.data["it-tools_endpoint"]
}

resource "authentik_policy_binding" "it-tools-app-policy-binding" {
  target         = authentik_application.it-tools-app.uuid
  order          = 0

  enabled        = true

  group          = authentik_group.it-tools-group.id
  negate         = false
  failure_result = false
}
