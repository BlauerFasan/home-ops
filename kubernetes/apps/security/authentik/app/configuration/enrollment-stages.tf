resource "authentik_stage_invitation" "enrollment-invitation" {
  name                             = "enrollment-invitation"
  continue_flow_without_invitation = false
}

resource "authentik_stage_user_write" "enrollemnt-invitation-write" {
  name                      = "enrollment-invitation-user-write"
  create_users_as_inactive  = true

  create_users_group        = authentik_group.new-user-group.id
}

resource "authentik_stage_prompt" "enrollment-source-promt" {
  name = "enrollment-source-promt"
  fields = [
    authentik_stage_prompt_field.enrollment-username-field.id,
    authentik_stage_prompt_field.enrollment-name-field.id,
    authentik_stage_prompt_field.enrollment-email-field.id,
    authentik_stage_prompt_field.enrollment-password-field.id,
    authentik_stage_prompt_field.repeat-enrollment-password-field.id
  ]
  validation_policies = [authentik_policy_password.password-policy.id]
}

resource "authentik_stage_prompt_field" "enrollment-username-field" {
  name                     = "enrollment-username-field"
  field_key                = "username"
  label                    = "Username"
  type                     = "username"

  required                 = true
  placeholder_expression   = false
  placeholder              = "Username"
  initial_value_expression = false
  initial_value            = ""
  order                    = 100
}

resource "authentik_stage_prompt_field" "enrollment-name-field" {
  name                     = "enrollment-name-field"
  field_key                = "name"
  label                    = "Name"
  type                     = "text"

  required                 = true
  placeholder_expression   = false
  placeholder              = "Name"
  initial_value_expression = false
  initial_value            = ""
  order                    = 201
}

resource "authentik_stage_prompt_field" "enrollment-email-field" {
  name                     = "enrollment-email-field"
  field_key                = "email"
  label                    = "Email"
  type                     = "email"

  required                 = true
  placeholder_expression   = false
  placeholder              = "Email"
  initial_value_expression = false
  initial_value            = ""
  order                    = 202
}

resource "authentik_stage_prompt_field" "enrollment-password-field" {
  name                     = "enrollment-password-field"
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

resource "authentik_stage_prompt_field" "repeat-enrollment-password-field" {
  name                     = "enrollment-password-field-repeat"
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

resource "authentik_stage_email" "enrollment-email-confirmation" {
  name = "enrollment-email-confirmation"

  activate_user_on_success  = true
  token_expiry              = "minutes=30"

  subject                   = "Account Confirmation"
  template                  = "email/account_confirmation.html"
}

resource "authentik_stage_authenticator_validate" "enrollment-totp-validation" {
  name                  = "enrollment-totp-authenticator-validation"

  not_configured_action = "configure"
  device_classes        = ["totp"]
  configuration_stages  = [
    data.authentik_stage.default-authenticator-totp-setup.id,
  ]

  last_auth_threshold   = "seconds=0"
}
