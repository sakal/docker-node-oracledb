FROM node:4.4-slim
MAINTAINER Tom Davidson <td@byu.edu>

ARG NODB_VER
ENV NODB_VER  ${NODB_VER:-1.9}
ENV LD_LIBRARY_PATH=/opt/oracle/instantclient:$LD_LIBRARY_PATH
ENV TNS_ADMIN /opt/oracle/config
ENV OCI_LIB_DIR /opt/oracle/instantclient
ENV OCI_INC_DIR /opt/oracle/instantclient/sdk/include

RUN mkdir -p /opt/oracle/instantclient
WORKDIR /opt/oracle/instantclient

COPY config ../config
ADD oracle-instantclient-12.1.tgz .

RUN ln -s libclntsh.so.12.1 libclntsh.so && \
    ln -s libocci.so.12.1 libocci.so

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
      libaio1 \
      python \
      build-essential && \
    npm install -g oracledb@$NODB_VER && \
    apt-get purge  --auto-remove build-essential -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
