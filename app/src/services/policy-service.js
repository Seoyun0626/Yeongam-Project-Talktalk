var db = require('../utils/db');


exports.upload = async function(req, res) {
    var conn;
    var resultcode = 0;
    try{
        conn = await db.getConnection();
        console.log('policy-service upload db getConnection');
        var name = req.body.name;
        var target = req.body.target;
        var supervision = req.body.supervision;
        var description = req.body.description;
        var fund = req.body.fund;
        var content = req.body.content;
        var query = "INSERT INTO webdb.tb_policy (policy_name, policy_target, policy_supervision, description, fund, content) VALUES ('" + name + "', '" + target + "', '" + supervision + "', '" + description + "', '" + fund + "', '" + content + "');";
        var rows = await conn.query(query); // 쿼리 실행
        console.log('policy-service upload success');
        return resultcode; //0이면 성공
    } catch(error) {
        console.log('policy-service upload:'+error);
        resultcode = 100;
    } finally {
        if (conn) conn.end();
    }
};