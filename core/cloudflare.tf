resource "cloudflare_zone" "raccoon" {
  zone = var.cloudflare_zone_name
}

resource "cloudflare_record" "raccoon_sso" {
  zone_id = cloudflare_zone.raccoon.id
  name    = "sso"
  value   = okta_domain.raccoon.dns_records[1].values[0]
  type    = "CNAME"
}

resource "cloudflare_record" "raccoon_sso_txt" {
  zone_id = cloudflare_zone.raccoon.id
  name    = "_oktaverification.sso"
  value   = okta_domain.raccoon.dns_records[0].values[0]
  type    = "TXT"
}

# https://github.com/cloudflare/terraform-provider-cloudflare/issues/1448
# resource "tls_private_key" "raccoon" {
#   algorithm = "RSA"
#   rsa_bits  = 2048
# }

# resource "tls_cert_request" "raccoon" {
#   key_algorithm   = tls_private_key.raccoon.algorithm
#   private_key_pem = tls_private_key.raccoon.private_key_pem

#   subject {
#     common_name  = "Cloudflare Origin Certificate"
#     street_address = []
#   }
# }

# resource "cloudflare_origin_ca_certificate" "raccoon" {
#   csr = tls_cert_request.raccoon.cert_request_pem

#   request_type       = "origin-rsa"
#   requested_validity = "730"

#   hostnames = [
#     "raccoon.team",
#     "*.raccoon.team",
#   ]
# }
