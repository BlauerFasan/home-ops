resource "authentik_group" "home-assistant-group" {
  name         = "home-assistant"
  is_superuser = false
}

resource "authentik_provider_oauth2" "home-assistant-provider" {
  name                  = "Home-Assistant"
  client_type           = "confidential"
  client_id             = data.sops_file.secrets.data["home-assistant_client-id"]
  client_secret         = data.sops_file.secrets.data["home-assistant_client-secret"]
  allowed_redirect_uris = [
    {
      matching_mode = "strict",
      url           = data.sops_file.secrets.data["home-assistant_redirect-url-1"],
    }
  ]

  # signing_key                = "ab375600-ac9a-4058-a529-dbbc7d960e7a"

  authorization_flow  = data.authentik_flow.default-provider-authorization-implicit-consent.id
  invalidation_flow   = data.authentik_flow.default-provider-invalidation-flow.id
  authentication_flow = authentik_flow.passwordless-flow.uuid

  property_mappings  = data.authentik_property_mapping_provider_scope.oidc-scopes-home-assistant.ids

  access_code_validity   = "minutes=1"
  access_token_validity  = "minutes=10"
  refresh_token_validity = "days=2"
  issuer_mode            = "per_provider"
}

resource "authentik_application" "home-assistant-app" {
  name              = "Home-Assistant"
  slug              = "home-assistant"
  protocol_provider = authentik_provider_oauth2.home-assistant-provider.id
  open_in_new_tab   = true
  meta_icon         = "https://community-assets.home-assistant.io/original/4X/5/f/7/5f7c448101f9378aa877224054ce41296d7d456d.png"
  meta_launch_url   = data.sops_file.secrets.data["home-assistant_endpoint"]
}

resource "authentik_policy_binding" "home-assistant-app-policy-binding" {
  target         = authentik_application.home-assistant-app.uuid
  order          = 0

  enabled        = true

  group          = authentik_group.home-assistant-group.id
  negate         = false
  failure_result = false
}
