resource "authentik_stage_identification" "login-identification" {
  name                      = "login-authentification-identification"
  user_fields               = ["username", "email"]

  password_stage            = data.authentik_stage.default-authentication-password.id

  # sources                   = ""

  case_insensitive_matching = false
  show_matched_user         = true

  # enrollment_flow           =
  passwordless_flow         = authentik_flow.passwordless-flow.uuid
  recovery_flow             = authentik_flow.recovery-password.uuid
}

resource "authentik_stage_authenticator_validate" "login-mfa-validation" {
  name                  = "login-mfa-authenticator-validation"

  not_configured_action = "configure"
  device_classes        = ["totp", "webauthn"]
  configuration_stages  = [
    data.authentik_stage.default-authenticator-totp-setup.id,
    data.authentik_stage.default-authenticator-webauthn-setup.id
  ]

  last_auth_threshold   = "seconds=0"
}

resource "authentik_stage_authenticator_validate" "login-passwordless-validation" {
  name                  = "login-passwordless-authenticator-validation"

  not_configured_action = "configure"
  device_classes        = ["webauthn"]
  configuration_stages  = [
    data.authentik_stage.default-authenticator-webauthn-setup.id
  ]
  webauthn_user_verification = "required"
  last_auth_threshold        = "seconds=0"
}
