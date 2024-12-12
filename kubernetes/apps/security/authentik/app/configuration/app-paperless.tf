resource "authentik_group" "paperless-group" {
  name         = "paperless-home"
  is_superuser = false
}

resource "authentik_provider_oauth2" "paperless-provider" {
  name                  = "Paperless Home"
  client_type           = "confidential"
  client_id             = data.sops_file.secrets.data["paperless_client-id"]
  client_secret         = data.sops_file.secrets.data["paperless_client-secret"]
  allowed_redirect_uris = [
    {
      matching_mode = "strict",
      url           = data.sops_file.secrets.data["paperless_redirect-url"],
    }
 ]

  # signing_key                = "ab375600-ac9a-4058-a529-dbbc7d960e7a"

  authorization_flow  = data.authentik_flow.default-provider-authorization-implicit-consent.id
  invalidation_flow   = data.authentik_flow.default-provider-invalidation-flow.id
  authentication_flow = authentik_flow.passwordless-flow.uuid

  property_mappings  = data.authentik_property_mapping_provider_scope.oidc-scopes-paperless.ids

  access_code_validity   = "minutes=1"
  access_token_validity  = "minutes=10"
  refresh_token_validity = "days=2"
  issuer_mode            = "per_provider"
}

resource "authentik_application" "paperless-app" {
  name              = "Paperless Home"
  slug              = "paperless-home"
  protocol_provider = authentik_provider_oauth2.paperless-provider.id
  open_in_new_tab   = true
  meta_icon         = "https://raw.githubusercontent.com/paperless-ngx/paperless-ngx/refs/heads/dev/resources/logo/web/svg/square.svg"
  meta_launch_url   = data.sops_file.secrets.data["paperless_endpoint"]
}

resource "authentik_policy_binding" "paperless-app-policy-binding" {
  target         = authentik_application.paperless-app.uuid
  order          = 0

  enabled        = true

  group          = authentik_group.paperless-group.id
  negate         = false
  failure_result = false
}
