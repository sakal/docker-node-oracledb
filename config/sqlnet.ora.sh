#!/usr/bin/env bash

cat > $1 << EOF
SQLNET.ENCRYPTION_SERVER = required
SQLNET.CRYPTO_SEED = '$(openssl rand -base64 32)'
SQLNET.ENCRYPTION_TYPES_CLIENT= (AES256)
EOF
