# docker-nodb
Parent image for node apps that need BYU's Oracle DBs.

Uses the Oracle [npm module](https://www.npmjs.com/package/oracledb) also found
on [github](https://github.com/oracle/node-oracledb). This parent image is based
on node4.4-slim. It does not add CMD or ENTRYPOINT and is intended to be used by
downstream images. It can be pulled from [quay.io](https://quay.io/repository/byuoit/node-oracledb).

What it does do is compile, install, and configure the Oracle Instant Client with
an encrypted connection to the onprem Oracle Connection Manager.

## Features ##

- baked-in Oracle instant client and sdk
- globally installed node-oracledb nodejs module<sup>1</sup>
- automated test to verify encryption connection before releasing
- Approx 450 MB image size

## Usage ##

- Use as a parent image. Tags are 'node-version-node-oracledb-version-commit-hash'
or 'latest'. Will switch to releases as tags when #18 is closed.

- Properly handle the dependency on the globally installed module. <sup>1</sup>
- Use [node-byuapi-framework](https://github.com/byu-oit-appdev/node-byuapi-framework)
or at least follow its [pattern](https://github.com/byu-oit-appdev/node-byuapi-framework/blob/master/middleware/oracledb.js)
for database config.

## Test ##

`make test` uses docker compose to build a stack and run test script. The test
includes a child image and a node app that requires the node-oracledb module,
connects to the onprem connection manager, and preforms a simple query to verify
the connection is encrypted.

## Contributing ##
Please use issues for support and feature requests. Also use merge/pull requests
for all code contribs.

Will first be closing #18 (migrate from make to npm) before working on #15 (circleci)



## Footnotes ##

#### 1. global node-oracledb ####

The module is installed globally in the parent image. Given that node-oracledb
is not a cli tool, this seems to not follow best practices compared to the
downstream app installing locally. In this case the global module complies the
database client -both taking a long time and having large dependencies that are
not necessarily needed downstream.

A few options to deal with the dependency that is globally installed in the parent
image:

- change NODE_PATH
- use npm link in the downstream docker image
- use npm link in the downstream app's package.json

The last option is recommend to ensure the link is established in the local
directory relative to the app's own package.json. All that needs to be done is
add the link command to the apps prestart script:
 ```
 "scripts": {
   "prestart" : "npm link oracledb"
 }
 ```
