module.exports = {

    user: process.env.ORACLEDB_USER || 'system',

    password: process.env.ORACLEDB_PASSWORD || 'oracle',

    // Setting externalAuth is optional.  It defaults to false.  See:
    // https://github.com/oracle/node-oracledb/blob/master/doc/api.md#extauth
    externalAuth: process.env.ORACLEDB_EXTERNALAUTH ? true : false,

    // For information on connection strings see:
    // https://github.com/oracle/node-oracledb/blob/master/doc/api.md#connectionstrings

    port: process.env.ORACLEDB_PORT || '1521',

    host: process.env.ORACLEDB_HOST || 'localhost',

    name: process.env.ORACLEDB_NAME || 'xe'

};

module.exports.connectString = module.exports.host + ':' + module.exports.port + '/' + module.exports.name;
