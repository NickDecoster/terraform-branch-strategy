resource "helm_release" "datahub" {
  chart = "datahub"
  name  = "nick-${var.env_prefix}-datahub"
}