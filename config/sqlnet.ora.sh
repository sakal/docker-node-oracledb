#!/usr/bin/env bash

# cat > $1 << EOF
# SQLNET.ENCRYPTION_SERVER = required
# SQLNET.CRYPTO_SEED = $(openssl rand -base64 32)
# SQLNET.ENCRYPTION_TYPES_CLIENT = (AES256)
# SQLNET.AUTHENTICATION_SERVICES = (NTS)
# NAMES.DEFAULT_DOMAIN = BYU.EDU
# NAMES.DIRECTORY_PATH = (TNSNAMES,EZCONNECT)
# EOF

cat > $1 << EOF
SQLNET.CRYPTO_CHECKSUM_TYPES_CLIENT = (MD5)
SQLNET.ENCRYPTION_TYPES_CLIENT = (AES256)
SQLNET.ENCRYPTION_CLIENT = required
SQLNET.CRYPTO_CHECKSUM_CLIENT = required

EOF
# 
#
#
# RUN cat >> /etc/bash.bashrc << EOF
# ORA_PATH=/opt/oracle/instantclient/config
# if [ -f $ORA_PATH/sqlnet.ora.sh ]; then
#   . $ORA_PATH/sqlnet.ora.sh $ORA_PATH/sqlnet.ora
# fi
# EOF
