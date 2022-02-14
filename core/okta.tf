resource "okta_domain" "raccoon" {
  name                    = "sso.raccoon.team"
  certificate_source_type = "MANUAL"
}

resource "okta_domain_verification" "raccoon" {
  domain_id = okta_domain.raccoon.id
}

# resource "okta_domain_certificate" "raccoon" {
#   domain_id   = okta_domain.raccoon.id
#   type        = "PEM"
#   certificate = cloudflare_origin_ca_certificate.raccoon.certificate
#   private_key = tls_private_key.raccoon.private_key_pem

#   # See https://developers.cloudflare.com/ssl/origin-configuration/origin-ca
#   certificate_chain = file("origin_ca_rsa_root.pem")

#   depends_on = [
#     cloudflare_origin_ca_certificate.raccoon,
#     cloudflare_record.raccoon_sso,
#     cloudflare_record.raccoon_sso_txt,
#   ]
# }
