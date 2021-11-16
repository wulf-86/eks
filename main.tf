module "eks" {
  source                          = "../terraform-aws-eks"
  cluster_name                    = local.cluster_name
  cluster_version                 = var.cluster_version
  subnets                         = lookup(var.vpc_options, "subnet_ids")
  vpc_id                          = lookup(var.vpc_options, "vpc_id")[0]
  cluster_endpoint_private_access = var.cluster_endpoint_private_access
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access

  worker_groups_launch_template        = var.worker_groups_launch_template
  worker_additional_security_group_ids = [data.terraform_remote_state.sg.outputs.internal_sg.id]

  tags = merge(local.tags,
    {
      "Name" = local.cluster_name
  })
  map_users = var.map_users
}
