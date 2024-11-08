resource "authentik_group" "firefly-group" {
  name         = "firefly-iii"
  is_superuser = false
}

resource "authentik_group" "firefly-family-group" {
  name         = "firefly-iii-family"
  is_superuser = false
  parent       = resource.authentik_group.firefly-group.id
  attributes   = jsonencode({additionalHeaders = {X-Authentik-Ffiii-Email = data.sops_file.secrets.data["firefly_mail"], X-Authentik-Ffiii-User = data.sops_file.secrets.data["firefly_mail"]}})
}

resource "authentik_provider_proxy" "firefly-provider" {
  name                = "Firefly-iii"
  external_host       = data.sops_file.secrets.data["firefly_endpoint"]
  authorization_flow  = data.authentik_flow.default-provider-authorization-implicit-consent.id
  invalidation_flow   = data.authentik_flow.default-provider-invalidation-flow.id
  authentication_flow = authentik_flow.passwordless-flow.uuid

  mode                = "forward_single"

  skip_path_regex     = "/api/v1/*"

  access_token_validity  = "minutes=10"
  refresh_token_validity = "days=2"
}

resource "authentik_application" "firefly-app" {
  name              = "Firefly-iii"
  slug              = "firefly-iii"
  protocol_provider = authentik_provider_proxy.firefly-provider.id
  open_in_new_tab   = true
  meta_icon         = "https://docs.firefly-iii.org/images/explanation/more-information/logo/logo-flame.png"
  meta_launch_url   = data.sops_file.secrets.data["firefly_endpoint"]
}

resource "authentik_policy_binding" "firefly-app-policy-binding" {
  target         = authentik_application.firefly-app.uuid
  order          = 0

  enabled        = true

  group          = authentik_group.firefly-group.id
  negate         = false
  failure_result = false
}
