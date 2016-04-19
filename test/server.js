  
var oracledb = require('oracledb');

oracledb.getConnection(
{
  user          : process.env.ORACLEDB_USER,
  password      : process.env.ORACLEDB_PASSWORD,
  connectString : process.env.ORACLEDB_CONNECTIONSTRING,
  
  //(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=<host name or ip>)(Port=31200)))(CONNECT_DATA=(SERVICE_NAME=<database name>.byu.edu))
  
},
function(err, connection)
{
  if (err) { console.error(err.message); return; }

//   connection.execute(
//     "SELECT department_id, department_name " +
//     "FROM departments " +
//     "WHERE manager_id < :id",
//     [110],  // bind value for :id
//     function(err, result)
//     {
//       if (err) { console.error(err.message); return; }
//         console.log(result.rows);
//     });
});