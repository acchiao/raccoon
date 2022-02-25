auto_scale          = true
cloudflare_domain   = "raccoon.team"
cluster_size        = "s-2vcpu-2gb"
digitalocean_domain = "acchiao.com"
environment         = "production"
max_nodes           = 5
min_nodes           = 2
node_count          = 1
project_name        = "raccoon"
region              = "nyc1"
release             = "stable"

# Helm charts
helm_timeout = 600
helm_wait    = false
