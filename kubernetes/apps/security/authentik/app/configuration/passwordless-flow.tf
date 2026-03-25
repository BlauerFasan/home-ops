resource "authentik_flow" "passwordless-flow" {
  name        = "Passwordless Flow"
  title       = "Passwordless Flow"
  slug        = "passwordless-flow"
  designation = "authentication"

  authentication     = "none"
  compatibility_mode = true
  denied_action      = "message_continue"
  policy_engine_mode = "any"

  # background         = ""
  layout             = "stacked"
}

resource "authentik_flow_stage_binding" "passwordless-auth-verification" {
  target = authentik_flow.passwordless-flow.uuid
  stage  = authentik_stage_authenticator_validate.login-passwordless-validation.id
  order  = 10
}

resource "authentik_flow_stage_binding" "passwordless-login-stage" {
  target = authentik_flow.passwordless-flow.uuid
  stage  = data.authentik_stage.default-authentication-login.id
  order  = 20

  evaluate_on_plan     = false
  re_evaluate_policies = true
}
