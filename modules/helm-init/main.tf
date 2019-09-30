module "helm-cli-install" {
  source = "../helm-cli-install"

  helm_version = "${var.helm_version}"
}

module "tiller" {
  source = "git@github.com:lsst-sqre/terraform-tinfoil-tiller"

  namespace       = "kube-system"
  service_account = "tiller"
  tiller_image    = "gcr.io/kubernetes-helm/tiller:${var.helm_version}"
}
