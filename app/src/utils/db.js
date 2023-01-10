const mariadb = require('mariadb');
var config = require('./db-config');
const pool = mariadb.createPool({
  host: config.host,
  user: config.user,
  password: config.password,
  database: config.database,
  allowPublicKeyRetrieval: true,
  connectionLimit: 5
});

// pool.getConnection(function(err, connection){  
//   if( err ){
//       if( err.code === 'PROTOCOL_CONNECTION_LOST' ) console.log('DATABASE CONNECTION WAS CLOSED');
//       if( err.code === 'ER_CON_COUNT_ERROR' ) console.log('DATABASE HAS TO MANY CONNECTIONS');
//       if( err.code === 'ECONNREFUSED' ) console.log('DATABASE CONNECTION WAS REFUSED');
//   } else {
//     console.log('DataBase is connected to '+process.env.DB_DATABASE);
//   }
  
//   if( connection ) connection.release();

  
//   return;
// });

module.exports = pool;