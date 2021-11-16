provider "kubernetes" {
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  host                   = module.eks.cluster_endpoint

  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    args        = ["token", "--cluster-id", module.eks.cluster_id]
    command     = "aws-iam-authenticator"
  }
}

resource "kubernetes_namespace" "ingress_nginx" {
  count = var.create_nginx_controller == true ? 1 : 0
  metadata {
    name = "ingress-nginx"
  }
}

resource "null_resource" "prometheus_repo" {
  provisioner "local-exec" {
    command = "helm repo add prometheus-community https://prometheus-community.github.io/helm-charts"
  }
}

resource "null_resource" "nginx_repo" {
  provisioner "local-exec" {
    command = "helm repo add stable https://charts.helm.sh/stable"
  }
}

resource "null_resource" "repo_update" {
  provisioner "local-exec" {
    command = "helm repo update"
  }
  depends_on = [null_resource.prometheus_repo, null_resource.nginx_repo]
  triggers = {
    version = null_resource.prometheus_repo.id
  }
}

resource "null_resource" "prometheus_operator_install" {
  provisioner "local-exec" {
    command = "helm upgrade --install kps prometheus-community/kube-prometheus-stack -n ${kubernetes_namespace.monitoring.id}"
  }
  depends_on = [null_resource.repo_update]
  triggers = {
    version = null_resource.repo_update.id
  }
}