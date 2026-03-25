# https://registry.terraform.io/providers/goauthentik/authentik/latest/docs

data "sops_file" "secrets" {
  source_file = "secrets.sops.json"
}

provider "authentik" {
  url   = data.sops_file.secrets.data["authentik_endpoint"]
  token = data.sops_file.secrets.data["authentik_token"]
  # Optionally set insecure to ignore TLS Certificates
  # insecure = true
}
