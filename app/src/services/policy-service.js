var db = require('../utils/db');


exports.upload = async function(req, res) {
    var conn;
    try{
        var json = {};
        json.code = 0;
        conn = await db.getConnection();
        console.log('policy-service upload db getConnection');
        var title = req.body.title;
        var content = req.body.content;
        var query = "INSERT INTO webdb.tb_policy (title, content) VALUES ('" + title + "', '" + content + "');";
        var rows = await conn.query(query); // 쿼리 실행
        console.log('policy-service upload success');
        return json;
    } catch(error) {
        console.log('policy-service upload:'+error);
    }
};