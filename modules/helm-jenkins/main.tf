locals {
  jenkins_namespace = "jenkins"
}

resource "helm_release" "jenkins" {
  chart     = "stable/jenkins"
  name      = "jenkins"
  version   = "${var.jenkins_helm_version}"
  namespace = "${local.jenkins_namespace}"
  values    = ["${file("${path.module}/resources/values.yaml")}"]
}
