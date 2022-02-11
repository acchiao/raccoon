resource "cloudflare_zone" "raccoon" {
  zone = "raccoon.team"
}

resource "tls_private_key" "raccoon" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P521"
}

resource "tls_cert_request" "raccoon" {
  key_algorithm   = tls_private_key.raccoon.algorithm
  private_key_pem = tls_private_key.raccoon.private_key_pem

  subject {
    common_name  = ""
    organization = "raccoon"
  }
}

resource "cloudflare_origin_ca_certificate" "raccoon" {
  csr = tls_cert_request.raccoon.cert_request_pem

  request_type = "origin-ecc"
  requested_validity = 1095

  hostnames = [
    "raccoon.team",
    "*.raccoon.team",
  ]
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
