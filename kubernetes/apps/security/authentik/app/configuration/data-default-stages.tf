data "authentik_stage" "default-authentication-password" {
  name = "default-authentication-password"
}
data "authentik_stage" "default-password-change-write" {
  name = "default-password-change-write"
}
data "authentik_stage" "default-source-enrollment-login" {
  name = "default-source-enrollment-login"
}
data "authentik_stage" "default-authentication-mfa-validation" {
  name = "default-authentication-mfa-validation"
}
data "authentik_stage" "default-authentication-login" {
  name = "default-authentication-login"
}
data "authentik_stage" "default-authenticator-totp-setup" {
  name = "default-authenticator-totp-setup"
}
data "authentik_stage" "default-authenticator-webauthn-setup" {
  name = "default-authenticator-webauthn-setup"
}


data "authentik_flow" "default-authorization-flow" {
  slug = "default-authentication-flow"
}
data "authentik_flow" "default-provider-authorization-implicit-consent" {
  slug = "default-provider-authorization-implicit-consent"
}
data "authentik_flow" "default-provider-invalidation-flow" {
  slug = "default-provider-invalidation-flow"
}
