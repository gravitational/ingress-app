#!/bin/bash
helm delete gravity-ingress
    --purge                                                                  \
    --namespace kube-system                                                  \