#!/bin/bash

# The script assumes that migrate CLI has already been installed on the host where the script is executed.
# Please, see https://github.com/golang-migrate/migrate/tree/master/cmd/migrate, to find instructions how to install CLI.

MIGRATION_NAME=$1
if [[ -z $MIGRATION_NAME ]]; then 
    echo "Name of migration must be provided as the first argument."
    exit 2
fi

migrate create -seq -dir migrations -ext sql $MIGRATION_NAME