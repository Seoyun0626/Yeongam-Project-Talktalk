var db = require('../../utils/db');
// const path = require("path");
var verifyToken = require("../../middleware/verify_token");



exports.getUserById = async function(req) {
    var conn;
    try {
        conn = await db.getConnection();
        console.log('mobile-user-service getUserById');

        // console.log('getUserById req.idPerson: ', req.idPerson);
        // const userid = 'test0416';
        const userdb = await conn.query(`CALL webdb.SP_GET_USER_BY_ID(?);`, [req.idPerson]);
        // console.log(userdb[0][0]);
        const result = userdb[0][0]
        
        return result;
       
        
    } catch (err) {
        console.log('mobile-login-service getUserById:'+ err);
    } finally {
      if(conn) conn.end();
    }
  
  }