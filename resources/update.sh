#!/bin/bash
/usr/local/bin/helm upgrade gravity-ingress                                  \
    /var/lib/gravity/resources/charts/nginx-ingress                          \
    --install                                                                \
    --atomic                                                                 \
    --namespace ingress                                                      \
    --set rbac.create=true                                                   \
    --set podSecurityPolicy.enabled=true                                     \
    --set controller.hostNetwork=true                                        \
    --set controller.kind=DaemonSet                                          \
    --set controller.daemonset.useHostPort=true                              \
    --set controller.service.type=NodePort
