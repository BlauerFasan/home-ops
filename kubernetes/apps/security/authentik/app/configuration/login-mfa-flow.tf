resource "authentik_flow" "login-mfa-flow" {
  name        = "Login MFA Flow"
  title       = "Login MFA Flow"
  slug        = "login-mfa-flow"
  designation = "authentication"

  authentication     = "none"
  compatibility_mode = true
  denied_action      = "message_continue"
  policy_engine_mode = "any"

  # background         = ""
  layout             = "stacked"
}

resource "authentik_flow_stage_binding" "login-mfa-identification" {
  target = authentik_flow.login-mfa-flow.uuid
  stage  = authentik_stage_identification.login-identification.id
  order  = 10
}

resource "authentik_flow_stage_binding" "login-mfa-authenticater" {
  target = authentik_flow.login-mfa-flow.uuid
  stage  = authentik_stage_authenticator_validate.login-mfa-validation.id
  order  = 20
}

resource "authentik_flow_stage_binding" "login-mfa-login-stage" {
  target = authentik_flow.login-mfa-flow.uuid
  stage  = data.authentik_stage.default-authentication-mfa-validation.id
  order  = 30
}
