resource "authentik_group" "mealie-user-group" {
  name         = "mealie-users"
  is_superuser = false
}
resource "authentik_group" "mealie-admin-group" {
  name         = "mealie-admins"
  is_superuser = false
}

resource "authentik_provider_oauth2" "mealie-provider" {
  name                  = "Mealie"
  client_type           = "confidential"
  client_id             = data.sops_file.secrets.data["mealie_client-id"]
  client_secret         = data.sops_file.secrets.data["mealie_client-secret"]
  allowed_redirect_uris = [
    {
      matching_mode = "strict",
      url           = data.sops_file.secrets.data["mealie_redirect-url-1"],
    },
    {
      matching_mode = "strict",
      url           = data.sops_file.secrets.data["mealie_redirect-url-2"],
    }
  ]

  # signing_key                = "7684d45e-84c7-496d-b7f1-23268b46ee8d"

  authorization_flow  = data.authentik_flow.default-provider-authorization-implicit-consent.id
  invalidation_flow   = data.authentik_flow.default-provider-invalidation-flow.id
  authentication_flow = authentik_flow.passwordless-flow.uuid

  property_mappings   = data.authentik_property_mapping_provider_scope.oidc-scopes-mealie.ids

  include_claims_in_id_token = true

  access_code_validity   = "minutes=1"
  access_token_validity  = "minutes=10"
  refresh_token_validity = "days=2"
  issuer_mode            = "per_provider"
  sub_mode               = "user_email"
}

resource "authentik_application" "mealie-app" {
  name              = "Mealie"
  slug              = "mealie"
  protocol_provider = authentik_provider_oauth2.mealie-provider.id
  open_in_new_tab   = true
  meta_icon         = "https://raw.githubusercontent.com/mealie-recipes/mealie/refs/heads/mealie-next/frontend/static/icons/android-chrome-192x192.png"
  meta_launch_url   = data.sops_file.secrets.data["mealie_endpoint"]
}

resource "authentik_policy_binding" "mealie-user-app-policy-binding" {
  target         = authentik_application.mealie-app.uuid
  order          = 1

  enabled        = true

  group          = authentik_group.mealie-user-group.id
  negate         = false
  failure_result = false
}
