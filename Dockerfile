FROM node:4.4-slim
MAINTAINER Tom Davidson <td@byu.edu>

RUN mkdir -p /opt/oracle/instantclient
WORKDIR /opt/oracle/instantclient
ADD oracle-instantclient-12.1.tgz .
COPY config ../config

ENV PATH /opt/oracle/instantclient:$PATH
ENV TNS_ADMIN /opt/oracle/sqlnet.ora

RUN ln -s libclntsh.so.12.1 libclntsh.so && \
    ln -s libocci.so.12.1 libocci.so && \
    cp ../config/oracle-instantclient.conf.example \
      /etc/ld.so.conf.d/oracle-instantclient.conf && \
    ldconfig

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
      libaio1 \
      python \
      build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    npm install -g oracledb

#suggest adding this command to nmp prestart to gen a new seed 
ONBUILD RUN ../config/sqlnet.ora.sh ../config/sqlnet.ora 
