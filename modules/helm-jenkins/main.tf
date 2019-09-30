locals {
  jenkins_namespace = "jenkins"
}

resource "template_file" "helm-jenkins-values-template" {
  template = "${file("${path.module}/resources/values-tmpl.yaml")}"
  vars {

  }
}

resource "helm_release" "jenkins" {
  chart = "stable/jenkins"
  name = "jenkins"
  version = "${var.jenkins_helm_version}"
  namespace = "${local.jenkins_namespace}"
  values = [
    "${template_file.helm-jenkins-values-template.rendered}"
  ]
}

