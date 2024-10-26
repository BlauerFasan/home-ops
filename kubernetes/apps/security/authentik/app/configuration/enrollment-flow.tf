resource "authentik_flow" "enrollemnt-invitation-flow" {
  name        = "Enrollment Invitation"
  title       = "Enrollment Invitation"
  slug        = "enrollment-invitation-flow"
  designation = "enrollment"

  authentication     = "none"
  compatibility_mode = true
  denied_action      = "message_continue"
  policy_engine_mode = "any"

  # background         = ""
  layout             = "stacked"
}

resource "authentik_flow_stage_binding" "enrollment-invitation" {
  target = authentik_flow.enrollemnt-invitation-flow.uuid
  stage  = authentik_stage_invitation.enrollment-invitation.id
  order  = 10
}

resource "authentik_flow_stage_binding" "enrollment-source-promt" {
  target = authentik_flow.enrollemnt-invitation-flow.uuid
  stage  = authentik_stage_prompt.enrollment-source-promt.id
  order  = 20
}

resource "authentik_flow_stage_binding" "enrollemnt-invitation-write" {
  target = authentik_flow.enrollemnt-invitation-flow.uuid
  stage  = authentik_stage_user_write.enrollemnt-invitation-write.id
  order  = 30
}

resource "authentik_flow_stage_binding" "enrollemnt-email-confirmation" {
  target = authentik_flow.enrollemnt-invitation-flow.uuid
  stage  = authentik_stage_email.enrollment-email-confirmation.id
  order  = 40
}

resource "authentik_flow_stage_binding" "enrollemnt-mfa-totp-setup" {
  target = authentik_flow.enrollemnt-invitation-flow.uuid
  stage  = authentik_stage_authenticator_validate.enrollment-totp-validation.id
  order  = 60
}

resource "authentik_flow_stage_binding" "enrollemnt-mfa-webathn-setup" {
  target = authentik_flow.enrollemnt-invitation-flow.uuid
  stage  = authentik_stage_authenticator_validate.login-passwordless-validation.id
  order  = 60
}

resource "authentik_flow_stage_binding" "enrollemnt-user-login" {
  target = authentik_flow.enrollemnt-invitation-flow.uuid
  stage  = data.authentik_stage.default-source-enrollment-login.id
  order  = 80
}
