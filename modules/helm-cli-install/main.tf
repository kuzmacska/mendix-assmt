resource "null_resource" "helm-install" {
  provisioner "local-exec" {
    working_dir = "${path.module}/resources"
    command     = "curl -sO https://storage.googleapis.com/kubernetes-helm/helm-${var.helm_version}-linux-amd64.tar.gz"
  }

  provisioner "local-exec" {
    working_dir = "${path.module}/resources"
    command     = "curl -sO https://storage.googleapis.com/kubernetes-helm/helm-${var.helm_version}-linux-amd64.tar.gz.sha256"
  }

  provisioner "local-exec" {
    working_dir = "${path.module}/resources"
    command     = "openssl sha1 -sha256 helm-v2.12.1-linux-amd64.tar.gz | awk '{print $2}' > helm_sha"
  }

  provisioner "local-exec" {
    working_dir = "${path.module}/resources"
    command     = "if [ $(cat helm_sha) != $(cat helm-${var.helm_version}-linux-amd64.tar.gz.sha256) ]; then echo 'helm sha is incorrect'; fi"
  }

  provisioner "local-exec" {
    working_dir = "${path.module}/resources"
    command     = "tar -xvzf helm-${var.helm_version}-linux-amd64.tar.gz --strip 1"
  }

  provisioner "local-exec" {
    working_dir = "${path.module}/resources"
    command     = "chmod +x helm"
  }

  provisioner "local-exec" {
    working_dir = "${path.module}/resources"
    command     = "mv helm /usr/local/bin"
  }

  provisioner "local-exec" {
    working_dir = "/usr/local/bin"
    command     = "helm init --client-only"
  }
}
