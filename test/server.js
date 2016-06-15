var oracledb = require('oracledb');
var dbConfig = require('./dbconfig.js');

var q = "SELECT 'ENCRYPTED' FROM v$session v " +
    "JOIN v$session_connect_info i ON  v.sid = i.sid AND v.serial# = i.serial# " +
    "WHERE v.audsid = userenv('sessionid') AND i.network_service_banner LIKE '%AES256%'";

console.log('connectString: ' + dbConfig.connectString + '\n');
console.log('querry string: ' + q + '\n');

oracledb.getConnection({
        user: dbConfig.user,
        password: dbConfig.password,
        connectString: dbConfig.connectString,
    },

    function(err, connection) {
        if (err) {
            console.error(err.message);
            return;
        }

        console.info('Connection successful.\n');

        connection.execute(
            q,
            function(err, result) {
                if (err) {
                    console.error(err.message);
                }
                if (result.rows.indexOf('ENCRYPTED') > -1) {
                    console.log("Failed test. Connection is: " + result.rows);
                    process.exit(1);
                } else {
                    console.log("Passed test. Connection is: " + result.rows);
                    process.exit(0);
                }
            }
        );
    });
