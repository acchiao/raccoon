resource "digitalocean_project" "raccoon" {
  name        = "${var.project_name}-${var.environment}"
  environment = var.project_environment
}

resource "digitalocean_project_resources" "raccoon" {
  project   = digitalocean_project.raccoon.id
  resources = []
}

resource "digitalocean_container_registry" "raccoon" {
  name                   = "${var.project_name}-${var.environment}-registry"
  subscription_tier_slug = "basic"
}

resource "digitalocean_vpc" "raccoon" {
  name   = "${var.project_name}-${var.environment}-${var.region}-vpc"
  region = var.region
}

resource "cloudflare_zone" "raccoon" {
  zone = var.cloudflare_zone_name
}

resource "okta_domain" "raccoon" {
  name                    = "${var.okta_subdomain}.${var.cloudflare_zone_name}"
  certificate_source_type = "OKTA_MANAGED"
}

resource "okta_domain_verification" "raccoon" {
  domain_id = okta_domain.raccoon.id
}

resource "cloudflare_record" "raccoon_sso" {
  zone_id = cloudflare_zone.raccoon.id
  name    = var.okta_subdomain
  value   = okta_domain.raccoon.dns_records[1].values[0]
  type    = "CNAME"
}

resource "cloudflare_record" "raccoon_sso_txt" {
  zone_id = cloudflare_zone.raccoon.id
  name    = "_acme-challenge.${var.okta_subdomain}"
  value   = okta_domain.raccoon.dns_records[0].values[0]
  type    = "TXT"
}

resource "okta_auth_server_default" "default" {
  name                      = "default"
  credentials_rotation_mode = "AUTO"
  issuer_mode               = "CUSTOM_URL"

  audiences = [
    "api://default",
  ]
}

# resource "tls_private_key" "raccoon" {
#   algorithm   = "ECDSA"
#   ecdsa_curve = "P521"
# }

# resource "tls_cert_request" "raccoon" {
#   key_algorithm   = tls_private_key.raccoon.algorithm
#   private_key_pem = tls_private_key.raccoon.private_key_pem

#   subject {
#     common_name  = ""
#     organization = "raccoon"
#   }
# }

# resource "cloudflare_origin_ca_certificate" "raccoon" {
#   csr = tls_cert_request.raccoon.cert_request_pem

#   request_type = "origin-ecc"
#   requested_validity = 1095

#   hostnames = [
#     "raccoon.team",
#     "*.raccoon.team",
#   ]
# }

# resource "okta_domain" "raccoon" {
#   name                    = "sso.raccoon.team"
#   certificate_source_type = "MANUAL"
# }

# resource "okta_domain_verification" "raccoon" {
#   domain_id = okta_domain.raccoon.id
# }

# resource "okta_domain_certificate" "raccoon" {
#   domain_id   = okta_domain.raccoon.id
#   type        = "PEM"
#   certificate = cloudflare_origin_ca_certificate.raccoon.certificate
#   private_key = tls_private_key.raccoon.private_key_pem

#   # See https://developers.cloudflare.com/ssl/0d2cd0f374da0fb6dbf53128b60bbbf7/origin_ca_ecc_root.pem
#   certificate_chain = file("origin_ca_ecc_root.pem")

#   depends_on = [
#     cloudflare_record.raccoon_sso,
#     cloudflare_record.raccoon_sso_txt,
#   ]
# }
