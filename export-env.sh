#!/bin/bash

POSTGRES_PASSWORD=${POSTGRES_PASSWORD:-local}
POSTGRES_USER=${POSTGRES_USER:-local}

cat << EOS > .env
POSTGRES_PASSWORD=$POSTGRES_PASSWORD
POSTGRES_USER=local
EOS
