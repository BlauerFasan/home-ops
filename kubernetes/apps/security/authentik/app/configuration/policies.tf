resource "authentik_policy_password" "password-policy" {
  name                    = "password-complexity"
  password_field          = "password"

  check_static_rules      = true
  length_min              = 12
  amount_uppercase        = 2
  amount_lowercase        = 2
  amount_digits           = 2
  amount_symbols          = 2
  error_message           = "foo"

  check_have_i_been_pwned = true
  hibp_allowed_count      = 0

  check_zxcvbn            = true
  zxcvbn_score_threshold  = 2
}
