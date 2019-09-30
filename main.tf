module "helm-init" {
  source       = "./modules/helm-init"
  helm_version = "${var.helm_version}"
}

resource "helm_release" "helm-nginx-ingress" {
  name      = "ingress-nginx"
  chart     = "stable/nginx-ingress"
  namespace = "ingress-nginx"
  version   = "${var.helm_nginx_ingress_version}"
  values    = ["${file("./resources/nginx-ingress-values.yaml")}"]
}

module "helm-jenkins" {
  source               = "./modules/helm-jenkins"
  jenkins_helm_version = "${var.jenkins_helm_version}"
}
