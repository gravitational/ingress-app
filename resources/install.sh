#!/bin/bash
helm install /var/lib/gravity/resources/charts/ingress-nginx                 \
    --name gravity-ingress                                                   \
    --namespace kube-system                                                  \
    --set rbac.create=true                                                   \
    --set podSecurityPolicy.enabled=true                                     \
    --set controller.hostNetwork=true                                        \
    --set controller.kind=DaemonSet                                          \
    --set controller.daemonset.useHostPort=true
