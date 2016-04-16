# [WIP] docker-node-oracledb
Base image for node apps that need Oracle DB.

Uses the Oracle [npm module](https://www.npmjs.com/package/oracledb) also found on [github](https://github.com/oracle/node-oracledb). This base image is based on node4.4-slim and is not actually​ ​base image at all. It does not add CMD or ENTRYPOINT and is intended to be a parent image. It can be pulled from [quay.io](https://quay.io/repository/byuoit/node-oracledb).

The advantage of using docker-node-oracledb is the baked-in Oracle instant client and sdk. There is an ONBUILD command '../config/sqlnet.ora.sh ../config/sqlnet.ora' the creats a TNS config file with a new crypto seed. It may be a good idea to add the command to a npm prestart script in order to get a new seed on each npm start.

This is WIP. Testing is limited. Review and contrib is needed.
