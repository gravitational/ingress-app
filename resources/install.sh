#!/bin/bash
/usr/local/bin/helm install /var/lib/gravity/resources/charts/nginx-ingress  \
    --name gravity-ingress                                                   \
    --namespace ingress                                                      \
    --set rbac.create=true                                                   \
    --set podSecurityPolicy.enabled=true                                     \
    --set controller.hostNetwork=true                                        \
    --set controller.kind=DaemonSet                                          \
    --set controller.daemonset.useHostPort=true
