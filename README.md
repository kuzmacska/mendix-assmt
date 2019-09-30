# Mendix Assignment

## Environment

Used simple kubeadm-made cluster for this task

## Prerequisites:
This project is meant to be run locally, so you need couple of tools to succeed, these versions are guaranteed working:

* Make 4.1 (e.g. apt install make)
* Terraform 0.11 (https://releases.hashicorp.com/terraform/0.11.13/ don't use 0.12!)
* Docker 18.09 (e.g. https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-docker-engine---community-1)
* kubectl client v1.13.4 (e.g. https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-on-linux)
* helm client v2.14.1 (e.g. https://helm.sh/docs/using_helm/#installing-helm)
* Kubernetes cluster version 1.12 and above
* Working kubeconfig should reside in ~/.kube/config file on your client machine

You can try the different versions of tools above but the result is not guaranteed.

## Usage:
Git clone this repository and cd into the cloned directory.

First, perform terraform initialization:

```make init```

Look at the changes before applying configuration on your infrastructure:

```make plan```

If the output is valid for you, apply the changes to your infrastructure:

```make apply```

## Description:
Helm modules reside in ```modules``` directory. 
These are helm-cli-install, helm-init and helm-jenkins chart.

## How to access Jenkins:
Nginx Ingress controller is deployed with a ```host network``` configuration and a custom HTTP port 8080
From machine having access to k8s hosts network:
```curl http://$(kubectl -n ingress-nginx get po -o wide -l app=nginx-ingress -l component=controller -o=jsonpath='{.items[0].status.podIP}'):8080/jenkins/```

* login: ```admin```
* password: ```printf $(kubectl get secret --namespace jenkins jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode);echo```

The sample JCASC pipeline is already there. Simple Python script is being executed from within a runner slave pod as required
