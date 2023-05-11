var db = require('../../utils/db');
const { v4: uuidv4 } = require('uuid');
const path = require("path");
// const { uuid } = require('uuidv4');

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
    var code_name = req.params.codeName;
    var code_detail = req.params.codeDetail;
    // console.log('policy-service getPolicyBySelect : ',code_name, code_detail);
    try {
        conn = await db.getConnection();
        console.log('policy-service getSearchPolicy db getConnecton');
        var query = "SELECT * FROM webdb.tb_policy WHERE " + code_name + " = ?;"; 
        var rows =  await conn.query(query, [code_detail]); // 쿼리 실행
        // console.log(rows);
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
    var resultcode = 0; // scrap
    try{

        const { uidPolicy, uidUser } = req.body;
        const conn = await db.getConnection();
        console.log('policy-service scrapOrUnscrapPolicy db getConnection');
        const isScrapdb = await conn.query('SELECT COUNT(uid_scraps) AS uid_scraps FROM webdb.tb_policy_scrap WHERE user_uid = ? AND policy_uid = ? LIMIT 1', [req.idPerson, uidPolicy]);

        console.log(isScrapdb[0]);

        //스크랩취소(unscrap)
        if (isScrapdb[0].uid_scraps > 0) {
            await conn.query('DELETE FROM webdb.tb_policy_scrap WHERE user_uid = ? AND policy_uid = ?', [req.idPerson, uidPolicy]);
            await conn.query('UPDATE webdb.tb_policy SET count_scraps = count_scraps - 1 WHERE uid = ?', [uidPolicy]);
            await conn.query('UPDATE webdb.tb_policy_scrap INNER JOIN webdb.tb_policy ON webdb.tb_policy_scrap.policy_uid = webdb.tb_policy.uid SET is_scrapped = 0 WHERE policy_uid = ?', [uidPolicy]);



            conn.end();
            resultcode = 1; // unscrap
        return resultcode; //res.status(200).json({ resultcode });
        }

  
        await conn.query('INSERT INTO webdb.tb_policy_scrap (uid_scraps, user_uid, policy_uid) VALUE (?,?,?)', [uuidv4(), req.idPerson, uidPolicy]);
        await conn.query('UPDATE webdb.tb_policy SET count_scraps = count_scraps + 1 WHERE uid = ?', [uidPolicy]);
        await conn.query('UPDATE webdb.tb_policy_scrap INNER JOIN webdb.tb_policy ON tb_policy_scrap.policy_uid = tb_policy.uid SET is_scrapped = 1 WHERE policy_uid = ?', [uidPolicy]);
       


        conn.end();
        return resultcode; //res.status(200).json({ resultcode });
  
    } catch(error) {

        console.log('policy-service scrapOrUnscrapPolicy:'+error);
        return res.status(500).json({ error });
    }
  };
  
    exports.getScrappedPolicy = async function(req, res) {
    var conn;
    try{
        conn = await db.getConnection();
        console.log('policy-service getScappedPolicy db getConnection');
        // console.log(req.idPerson);
        const policydb = await conn.query(`CALL webdb.SP_GET_SCRAPPED_POLICY(?);`, [req.idPerson]);
        // console.log(policydb[0]);
        
        return policydb[0];
    } catch(error) {
        console.log('policy-service getScappedPolicy:'+error);
    } finally {
        conn.release();
    }
    };

    exports.checkPolicyScrapped = async function(req, res) {
        var conn;
        try {
            conn = await db.getConnection();
            console.log('policy-service checkPolicyScrapped db getConnection');
            const uidPolicy = req.params.uidPolicy;
            const uidUser = req.idPerson;
            const query = `SELECT IFNULL(is_scrapped, 0) AS isScrapped FROM webdb.tb_policy_scrap WHERE user_uid = (?) AND policy_uid = (?);`;
            const result = await conn.query(query, [uidUser, uidPolicy]);
    
            const isScrapped = result[0]?.isScrapped || 0;
            // console.log(isScrapped);
            return {
                isScrapped: isScrapped == 1 ? 1 : 0
            };
        
        } catch(error){
            console.log('policy-service checkPolicyScrapped:'+error);
            return {
                resp: false,
                error: error.message,
                isScrapped : 0
            };
        } finally {
            conn.release();
        }
    };

    
    


