locals {
  cluster_name = "${var.cluster_prefix}-${var.env}"
  tags         = merge(var.tags, var.global_tags)
  env_index    = replace(var.env, "-", "_")
}
