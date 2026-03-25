resource "authentik_flow" "login-basic-flow" {
  name        = "Login Basic Flow"
  title       = "Login Basic Flow"
  slug        = "login-basic-flow"
  designation = "authentication"

  authentication     = "none"
  compatibility_mode = true
  denied_action      = "message_continue"
  policy_engine_mode = "any"

  # background         = ""
  layout             = "stacked"
}

resource "authentik_flow_stage_binding" "login-basic-identification" {
  target = authentik_flow.login-basic-flow.uuid
  stage  = authentik_stage_identification.login-identification.id
  order  = 10
}

resource "authentik_flow_stage_binding" "login-basic-authenticater" {
  target = authentik_flow.login-basic-flow.uuid
  stage  = data.authentik_stage.default-authentication-mfa-validation.id
  order  = 20
}

resource "authentik_flow_stage_binding" "login-basic-login-stage" {
  target = authentik_flow.login-basic-flow.uuid
  stage  = data.authentik_stage.default-authentication-login.id
  order  = 30
}
