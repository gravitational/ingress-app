#!/bin/bash
/usr/local/bin/helm delete gravity-ingress                                   \
    --purge                                                                  \
    --namespace ingress                                                      \
