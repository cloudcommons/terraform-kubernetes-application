# Kubernetes application

This Terraform module mimics (most) the Helm chart out of the box features and behaviours that you can find when ```helm create mychart```, but relaying purely and solely on Terraform.

## Features

* Creates a new namespace for the application+environment
* Creates deployment for one or more Docker container versions. Ingress rules are used to route traffic to the right service
  * Possiblity of configure liveness and readiness probe
  * Possibility of mounting secrets as volues
* One service per deployment is created. Intended to use ClusterIP + Nginx-ingress
* One ingress for all services is deployed, including the rules to route the traffic to the right service

## Additional features

You can add the following features by creating your own terraform modules and referencing to module outputs:

* Network policies

## How to use

You can find the full list of paramteres [here](variables.tf)
You can find an example configuration file [here](examples/app.tfvars)