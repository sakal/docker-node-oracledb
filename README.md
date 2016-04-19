# [WIP] docker-node-oracledb
Base image for node apps that need BYU's Oracle DB.

Uses the Oracle [npm module](https://www.npmjs.com/package/oracledb) also found on [github](https://github.com/oracle/node-oracledb). This base image is based on node4.4-slim and is not actually​ ​base image at all. It does not add CMD or ENTRYPOINT and is intended to be a parent image. It can be pulled from [quay.io](https://quay.io/repository/byuoit/node-oracledb).


## Features ##

 - [wip] baked-in Oracle instant client and sdk. 
 - [finished] an ONBUILD command '../config/sqlnet.ora.sh ../config/sqlnet.ora' that creates a TNS config file with a new crypto seed.
 - [no started] example db connect script
 - [wip] automated test to verify TNS connection before releasing
 
## test ##

Using docker compose to build a stack and run test script.