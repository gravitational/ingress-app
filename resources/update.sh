#!/bin/bash

SVC_TYPE="NodePort"

if [ "${GRAVITY_CLUSTER_PROVIDER}" == "aws" ] || \
   [ "${GRAVITY_CLUSTER_PROVIDER}" == "gce" ] ; then
  SVC_TYPE="LoadBalancer"
fi

/usr/local/bin/helm upgrade gravity-ingress                                  \
    /var/lib/gravity/resources/charts/nginx-ingress                          \
    --install                                                                \
    --atomic                                                                 \
    --namespace ingress                                                      \
    --set rbac.create=true                                                   \
    --set podSecurityPolicy.enabled=true                                     \
    --set controller.allowSnippetAnnotations=false                           \
    --set controller.hostNetwork=true                                        \
    --set controller.kind=DaemonSet                                          \
    --set controller.daemonset.useHostPort=true                              \
    --set controller.service.type=${SVC_TYPE}
