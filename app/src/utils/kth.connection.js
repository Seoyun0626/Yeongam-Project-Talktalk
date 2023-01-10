const dbConfig = require('./kth.db.config');
const mysql = require('mariadb');


const pool = mysql.createPool({
  host: dbConfig.HOST,
  user: dbConfig.USER,
  password: dbConfig.PASSWORD,
  port:dbConfig.PORT,
  database: dbConfig.DATABASE,
});

// const connect = async () => {
//     const connection = await createPool({
//         host: 'localhost',
//         user: 'root',
//         password: '1004',
//         database: 'webdb',
//         connectionLimit: 10
//     });
//     return connection;
// };



module.exports = pool;