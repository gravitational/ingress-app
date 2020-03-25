#!/bin/sh

set -eu

echo "--> Assuming changeset from the environment: $RIG_CHANGESET"

if [ $1 = "update" ]; then

    echo "--> Checking: $RIG_CHANGESET"
    if rig status ${RIG_CHANGESET} --retry-attempts=1 --retry-period=1s; then
        exit 0
    fi

    echo "--> Starting upgrade, changeset: $RIG_CHANGESET"
    rig cs delete --force -c cs/${RIG_CHANGESET}

    echo "--> Checking status"
    rig status ${RIG_CHANGESET} --retry-attempts=120 --retry-period=1s --debug

    echo "--> Freezing"
    rig freeze

elif [ $1 = "rollback" ]; then

    echo "--> Reverting changeset $RIG_CHANGESET"
    rig revert
    rig cs delete --force -c cs/${RIG_CHANGESET}

else

    echo "--> Missing argument, should be either 'update' or 'rollback'"

fi
