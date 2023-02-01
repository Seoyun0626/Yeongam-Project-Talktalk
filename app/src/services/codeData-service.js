var db = require('../utils/db');
var bkfd2Password = require('pbkdf2-password');
var hasher = bkfd2Password();


exports.fetchData = async function(req, res) {
    try {
        // var result = await db.query('SELECT * FROM webdb.tb');
        return result;
    } catch (error) {
        console.log('codeData-controller fetchData error:'+error);
    }
}
