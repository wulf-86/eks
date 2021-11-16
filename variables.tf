variable "vpc_options" {
  description = "VPC related options, see below. Adding or removing this configuration forces a new resource"
  type        = map(any)
  default     = {}
}

variable "cluster_prefix" {
  type        = string
  description = "Cluster name prefix"
}

variable "cluster_version" {
  type        = string
  description = "k8s version"
  default     = "1.18"
}

variable "worker_groups_launch_template" {
  type        = any
  description = "Launch template for worker groups"
  default = [
    {
      name                 = "wg-1"
      instance_type        = "t3.small"
      asg_desired_capacity = 2
    }
  ]
}

variable "cluster_endpoint_private_access" {
  type    = string
  default = true
}

variable "cluster_endpoint_public_access" {
  type    = string
  default = false
}

variable "create_nginx_controller" {
  type    = bool
  default = false
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap. See examples/basic/variables.tf for example format."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

variable "tags" {
  type        = map(string)
  description = "Tags for EKS cluster"
  default     = {}
}