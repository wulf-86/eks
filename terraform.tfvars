vpc_options = {
  subnet_ids = ["subnet-0f793c64a36718ad4", "subnet-0b557743c0a8b5b4d"] # Private
  az_ids     = ["us-east-2a", "us-east-2b"]
  vpc_id     = ["vpc-22fdd145"]
}

cluster_prefix                  = "k8s"
cluster_version                 = "1.19"
cluster_endpoint_private_access = true
cluster_endpoint_public_access  = false
create_nginx_controller         = true

worker_groups_launch_template = [
  {
    name                 = "wg-1"
    instance_type        = "m5.large"
    asg_desired_capacity = 2
  }
]

map_users = [
  {
    userarn = "arn:aws:iam::004782760466:user/aleksey.temlyakov"
    username = "aleksey.temlyakov"
    groups = [
      "system:masters"
    ]
  }
]

tags = {}