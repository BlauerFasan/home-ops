resource "authentik_stage_identification" "recovery-identification" {
  name                      = "recovery-authentification-identification"
  user_fields               = ["username", "email"]

  # password_stage            = ""

  # sources                   = ""

  case_insensitive_matching = false
  show_matched_user         = true

  # enrollment_flow           =
  # passwordless_flow         =
  # recovery_flow             = authentik_flow.recovery-password.id
}

resource "authentik_stage_email" "recovery-email" {
  name = "recovery-email"

  activate_user_on_success  = true
  token_expiry              = 30

  subject                   = "Password Recovery"
  template                  = "email/password_reset.html"
}

resource "authentik_stage_prompt" "recovery-password-promt" {
  name = "recovery-password-promt"
  fields = [
    authentik_stage_prompt_field.password-field.id,
    authentik_stage_prompt_field.repeat-password-field.id
  ]
  validation_policies = [authentik_policy_password.password-policy.id]
}

resource "authentik_stage_prompt_field" "password-field" {
  name                     = "recovery-password-change-field"
  field_key                = "password"
  label                    = "Password"
  type                     = "password"

  required                 = true
  placeholder_expression   = false
  placeholder              = "Password"
  initial_value_expression = false
  initial_value            = ""
  order                    = 300
}

resource "authentik_stage_prompt_field" "repeat-password-field" {
  name                     = "recovery-password-change-field-repeat"
  field_key                = "password_repeat"
  label                    = "Password (repeat)"
  type                     = "password"

  required                 = true
  placeholder_expression   = false
  placeholder              = "Password (repeat)"
  initial_value_expression = false
  initial_value            = ""
  order                    = 301
}
