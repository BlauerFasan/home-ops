resource "authentik_group" "sparkyfitness-group" {
  name         = "sparkyfitness"
  is_superuser = false
}

resource "authentik_provider_oauth2" "sparkyfitness-provider" {
  name                  = "Sparkyfitness"
  client_type           = "confidential"
  client_id             = data.sops_file.secrets.data["sparkyfitness_client-id"]
  client_secret         = data.sops_file.secrets.data["sparkyfitness_client-secret"]
  allowed_redirect_uris = [
    {
      matching_mode = "strict",
      url           = data.sops_file.secrets.data["sparkyfitness_redirect-url"],
    }
  ]

  # signing_key                = "7684d45e-84c7-496d-b7f1-23268b46ee8d"

  authorization_flow  = data.authentik_flow.default-provider-authorization-implicit-consent.id
  invalidation_flow   = data.authentik_flow.default-provider-invalidation-flow.id
  authentication_flow = authentik_flow.passwordless-flow.uuid

  property_mappings  = data.authentik_property_mapping_provider_scope.oidc-scopes-sparkyfitness.ids

  access_code_validity   = "minutes=1"
  access_token_validity  = "minutes=10"
  refresh_token_validity = "days=2"
  issuer_mode            = "per_provider"
}

resource "authentik_application" "sparkyfitness-app" {
  name              = "sparkyfitness"
  slug              = "Sparkyfitness"
  protocol_provider = authentik_provider_oauth2.sparkyfitness-provider.id
  open_in_new_tab   = true
  meta_icon         = ""
  meta_launch_url   = data.sops_file.secrets.data["sparkyfitness_endpoint"]
}

resource "authentik_policy_binding" "sparkyfitness-app-policy-binding" {
  target         = authentik_application.sparkyfitness-app.uuid
  order          = 0

  enabled        = true

  group          = authentik_group.sparkyfitness-group.id
  negate         = false
  failure_result = false
}
