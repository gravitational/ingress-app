#!/bin/bash

# TO BE ON THE SAFE SIDE, FOR NOW WE CLEAN UP AND REINSTALL THE WHOLE 
# GRAVITY INGRESS CONTROLLER HELM RELEASE

/usr/local/bin/helm delete gravity-ingress                                   \
    --purge                                                                  \
    --namespace kube-system                                                  \

/usr/local/bin/helm install /var/lib/gravity/resources/charts/nginx-ingress  \
    --name gravity-ingress                                                   \
    --namespace kube-system                                                  \
    --set rbac.create=true                                                   \
    --set podSecurityPolicy.enabled=true                                     \
    --set controller.hostNetwork=true                                        \
    --set controller.kind=DaemonSet                                          \
    --set controller.daemonset.useHostPort=true