resource "authentik_flow" "recovery-password" {
  name               = "Revocery Password Flow"
  title              = "Revocery Password Flow"
  slug               = "recovery-password-flow"
  designation        = "recovery"

  authentication     = "none"
  compatibility_mode = true
  denied_action      = "message_continue"
  policy_engine_mode = "any"

  # background         = ""
  layout             = "stacked"
}

resource "authentik_flow_stage_binding" "recovery-identification" {
  target = authentik_flow.recovery-password.uuid
  stage  = authentik_stage_identification.recovery-identification.id
  order  = 10
}

resource "authentik_flow_stage_binding" "recovery-email" {
  target = authentik_flow.recovery-password.uuid
  stage  = authentik_stage_email.recovery-email.id
  order  = 20
}

resource "authentik_flow_stage_binding" "recovery-password-promt" {
  target = authentik_flow.recovery-password.uuid
  stage  = authentik_stage_prompt.recovery-password-promt.id
  order  = 30
}

resource "authentik_flow_stage_binding" "recovery-user-write" {
  target = authentik_flow.recovery-password.uuid
  stage  = data.authentik_stage.default-password-change-write.id
  order  = 40
}
