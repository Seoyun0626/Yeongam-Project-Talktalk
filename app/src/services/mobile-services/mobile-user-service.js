var db = require('../../utils/db');
// const path = require("path");

exports.getUserById = async function(req, res) {
    var conn;
    try {
        conn = await db.getConnection();
      var searchUser = req.url.split('=')[1]; //바꿔야 하나?
        
        var query = 'SELECT * FROM webdb.tb_user';
        rows = await conn.query(query);
        
        return rows;
       
        
    } catch (err) {
        console.log('mobile-login-service getUserById:'+error);
    } finally {
      if(conn) conn.end();
    }
  
  }