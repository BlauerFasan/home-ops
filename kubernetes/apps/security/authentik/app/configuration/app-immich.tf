resource "authentik_group" "immich-group" {
  name         = "immich"
  is_superuser = false
}

resource "authentik_provider_oauth2" "immich-provider" {
  name                  = "Immich"
  client_type           = "confidential"
  client_id             = data.sops_file.secrets.data["immich_client-id"]
  client_secret         = data.sops_file.secrets.data["immich_client-secret"]
  allowed_redirect_uris = [
    {
      matching_mode = "strict",
      url           = data.sops_file.secrets.data["immich_redirect-url-1"],
    },
    {
      matching_mode = "strict",
      url           = data.sops_file.secrets.data["immich_redirect-url-2"],
    },
    {
      matching_mode = "strict",
      url           = data.sops_file.secrets.data["immich_redirect-url-3"],
    }
  ]

  # signing_key                = "ab375600-ac9a-4058-a529-dbbc7d960e7a"

  authorization_flow  = data.authentik_flow.default-provider-authorization-implicit-consent.id
  invalidation_flow   = data.authentik_flow.default-provider-invalidation-flow.id
  authentication_flow = authentik_flow.passwordless-flow.uuid

  property_mappings  = data.authentik_property_mapping_provider_scope.oidc-scopes-immich.ids

  access_code_validity   = "minutes=1"
  access_token_validity  = "minutes=10"
  refresh_token_validity = "days=2"
  issuer_mode            = "per_provider"
}

resource "authentik_application" "immich-app" {
  name              = "Immich"
  slug              = "immich"
  protocol_provider = authentik_provider_oauth2.immich-provider.id
  open_in_new_tab   = true
  meta_icon         = "https://raw.githubusercontent.com/immich-app/immich/refs/heads/main/design/immich-logo-stacked-light.svg"
  meta_launch_url   = data.sops_file.secrets.data["immich_endpoint"]
}

resource "authentik_policy_binding" "immich-app-policy-binding" {
  target         = authentik_application.immich-app.uuid
  order          = 0

  enabled        = true

  group          = authentik_group.immich-group.id
  negate         = false
  failure_result = false
}
