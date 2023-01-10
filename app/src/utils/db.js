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

module.exports = pool;