var db = require('../../utils/db');
const path = require("path");

exports.getAllPolicy = async function(req, res) {
    var conn;
    try{
        conn = await db.getConnection();
        console.log('policy-service getAllPolicy db getConnection');
        var query = "SELECT * FROM webdb.tb_policy;";
        var rows = await conn.query(query); // 쿼리 실행
        // console.log(rows[0]);

        // console.log(rows);
        return rows;
    } catch(error) {
        console.log('policy-service getAllPolicy:'+error);
    } finally {
        conn.release();
    }
}





exports.getSearchPolicy = async function(req, res) {
    // console.log('policy-service getSearchPolicy : ',req.params.searchValue);
    var conn;
    var searchValue = '%' + req.params.searchValue + '%';
    // console.log('policy-service getSearchPolicy : ',searchValue);
    try {
        conn = await db.getConnection();
        console.log('policy-service getSearchPolicy db getConnection');
        var query = "SELECT * FROM webdb.tb_policy WHERE policy_name LIKE" + "'"+searchValue+"'" + ";"; 
        var rows =  await conn.query(query); // 쿼리 실행
        // console.log('policy-service getSerachPolicy success');
        return rows;
    } catch(error){
        console.log('policy-service getSearchPolicy:'+error);
    } finally {
        conn.release();
    }
}
exports.getPolicyBySelect = async function(req, res){
    var conn;
    var code = req.params.code;
    // console.log('policy-service getPolicyBySelect : ',code);
    try {
        conn = await db.getConnection();
        console.log('policy-service getSearchPolicy db getConnecton');
        var query = "SELECT * FROM webdb.tb_policy WHERE policy_field_code = " + "'"+code+"'" + ";"; 
        var rows =  await conn.query(query); // 쿼리 실행
        // console.log('policy-service getSelectPolicy success');
        return rows;
    } catch(error){
        console.log('policy-service getSelectPolicy:'+error);
    } finally {
        conn.release();
    }
}

exports.getAllPolicyForSearch = async function(req, res) {
    var conn;
    try{
        conn = await db.getConnection();
        console.log('policy-service getAllPolicyForSearch db getConnection');
        var query = "SELECT * FROM webdb.tb_policy;";
        var rows = await conn.query(query); // 쿼리 실행
        // console.log(rows[0]);
        // console.log(rows[1]);
        // console.log(rows[2]); 
        return rows;
    } catch(error) {
        console.log('policy-service getAllPolicyForSearch:'+error);
    } finally {
        conn.release();
    }
}

exports.scrapOrUnscrapPolicy = async function(req, res) {
    console.log('policy_service scrapOrUnscrapPolicy', req.body);
    var resultcode = 0;
    try{
        const {uidPolicy, uidUser} = req.body;
        const conn = await db.getConnection();
        console.log('policy-service scrapOrUnscrapPolicy db getConnection');

        const isScrapdb = await conn.query('SELECT COUNT(uid_scraps) AS uid_scraps FROM webdb.tb_policy_scrap WHERE user_uid = ? AND policy_uid = ? LIMIT 1', [req.idPerson, uidPolicy]);
        
        if(isScrapdb[0][0].uid_scraps > 0) {
            await conn.query('DELETE FROM webdb.tb_policy_scrap WHERE user_uid = ? AND policy_uid = ?', [req.idPerson, uidPolicy]);
            conn.end();
            resultcode = 1; // unscrap
            return resultcode;
        }
        await conn.query('INSERT INTO webdb.tb_policy_scrap (uid_scraps, user_uid, policy_uid) VALUE (?,?,?)', [uuidv4(), req.idPerson, uidPolicy]);
        conn.end();
        return resultcode;



        // var query = "update  webdb.tb_policy set count_scrps = count_scraps+1 where board_idx = 1;";
        // var rows = await conn.query(query); // 쿼리 실행
        // // console.log(rows);
        // return rows;
    } catch(error) {
        console.log('policy-service scrapOrUnscrapPolicy:'+error);
    } finally {
        conn.release();
    }
};