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
RUN chmod +x ../config/*.sh

ENV PATH /opt/oracle/instantclient:$PATH
ENV LD_LIBRARY_PATH  /opt/oracle/instantclient
ENV TNS_ADMIN /opt/oracle/config
ENV NODE_PATH /usr/local/lib/node_modules

RUN ln -s libclntsh.so.12.1 libclntsh.so && \
    ln -s libocci.so.12.1 libocci.so && \
    cp ../config/oracle-instantclient.conf.example \
      /etc/ld.so.conf.d/oracle-instantclient.conf && \
    ldconfig

RUN npm install -g oracledb

#suggest adding this command to nmp prestart to gen a new seed
ONBUILD RUN ../config/sqlnet.ora.sh ../config/sqlnet.ora
