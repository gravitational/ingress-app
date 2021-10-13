#!/bin/bash

SVC_TYPE="NodePort"

if [ "${GRAVITY_CLUSTER_PROVIDER}" == "aws" ] || \
   [ "${GRAVITY_CLUSTER_PROVIDER}" == "gce" ] ; then
  SVC_TYPE="LoadBalancer"
fi

/usr/local/bin/helm3 install gravity-ingress /var/lib/gravity/resources/charts/ingress-nginx \
    --namespace ingress \
    --set rbac.create=true \
    --set podSecurityPolicy.enabled=true \
    --set controller.allowSnippetAnnotations=false \
    --set controller.hostNetwork=true \
    --set controller.kind=DaemonSet \
    --set controller.daemonset.useHostPort=true \
    --set controller.service.type=${SVC_TYPE}
