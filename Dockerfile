FROM node:4.4-slim
MAINTAINER Tom Davidson <td@byu.edu>

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
      libaio1 \
      python \
      build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/oracle/instantclient
WORKDIR /opt/oracle/instantclient

ADD oracle-instantclient-12.1.tgz .
COPY config ../config
RUN ln -s libclntsh.so.12.1 libclntsh.so && \
    ln -s libocci.so.12.1 libocci.so && \
    chmod +x ../config/*.sh

ENV oracledb_ver 1.9


#ENV PATH /opt/oracle/instantclient:$PATH

ENV LD_LIBRARY_PATH=/opt/oracle/instantclient:$LD_LIBRARY_PATH
ENV TNS_ADMIN /opt/oracle/config
ENV OCI_LIB_DIR /opt/oracle/instantclient
ENV OCI_INC_DIR /opt/oracle/instantclient/sdk/include


RUN npm install -g oracledb@$oracledb_ver


#suggest adding this command to nmp prestart to gen a new seed
ONBUILD RUN ../config/sqlnet.ora.sh ../config/sqlnet.ora
