var db = require('../utils/db');
var bkfd2Password = require('pbkdf2-password');
var hasher = bkfd2Password();
var utils = require('../utils/utils');


exports.fetchData = async function(req, res) {
    try {
        // var result = await db.query('SELECT * FROM webdb.tb');
        return result;
    } catch (error) {
        console.log('codeData-controller fetchData error:'+error);
    }
};
  exports.getPolicyField = async function(req, res) {
    var resultcode = 0;
    var conn;
    try{
      conn = await db.getConnection();
      var query = "SELECT policy_field_code,policy_field_name FROM webdb.tb_policy_field_code";
      var rows = await conn.query(query); // 쿼리 실행
      return rows;
    } catch(error) {
      console.log('code-service getPolicyField:'+error);
    }
  };


  exports.getPolicyCharacter = async function(req, res) {
    var resultcode = 0;
    var conn;
    try{
      conn = await db.getConnection();
      var query = "SELECT policy_character_code,policy_character_name FROM webdb.tb_policy_character_code";
      var rows = await conn.query(query); // 쿼리 실행
      return rows;
    } catch(error) {
      console.log('code-service getPolicyCharacter:'+error);
    }
  };

  exports.getPolicyInstitution = async function(req, res) {
    var resultcode = 0;
    var conn;
    try{
      conn = await db.getConnection();
      var query = "SELECT policy_institution_code,policy_institution_name FROM webdb.tb_policy_institution_code";
      var rows = await conn.query(query); // 쿼리 실행
      return rows;
    } catch(error) {
      console.log('code-service getPolicyInstitution:'+error);
    }
  };

exports.getTarget = async function(req, res) {
  var resultcode = 0;
  var conn;
  try{
    conn = await db.getConnection();
    var query = "SELECT policy_target_code,policy_target_name FROM webdb.tb_policy_target_code";
    var rows = await conn.query(query); // 쿼리 실행
    return rows;
  } catch(error) {
    console.log('code-service getTarget:'+error);
  }
};

exports.fetchPolicyData = async function(req, res) {
    try {
        var result = await db.query('SELECT policy_target_code,policy_target_name,policy_institution_code,policy_institution_name FROM webdb.tb_policy_target_code, webdb.tb_policy_institution_code');
        // var result = await db.query('SELECT policy_target_code,policy_target_name FROM webdb.tb_policy_target_code,webdb.tb_policy_institution_code,webdb.tb_policy_character_code,webdb.tb_policy_field_code');
        return result;
    } catch (error) {
        console.log('codeData-controller fetchPolicyData error:'+error);
    }
}


exports.getCodeData = async function(req, res) {
    try {
      conn = await db.getConnection();
      // 공통코드별로 상세코드를 가져와 json으로 만들어서 리턴
      var json = {};
      var query = "SELECT b.code_detail, b.code_detail_name FROM webdb.tb_common_code as a inner join webdb.tb_common_code_detail as b on a.code = b.code where a.code = 1";
      json.user_type = await conn.query(query); // 쿼리 실행
      var query = "SELECT b.code_detail, b.code_detail_name FROM webdb.tb_common_code as a inner join webdb.tb_common_code_detail as b on a.code = b.code where a.code = 2";
      json.youthAge_code = await conn.query(query);
      var query = "SELECT b.code_detail, b.code_detail_name FROM webdb.tb_common_code as a inner join webdb.tb_common_code_detail as b on a.code = b.code where a.code = 3";
      json.parentsAge_code = await conn.query(query);
      var query = "SELECT b.code_detail, b.code_detail_name FROM webdb.tb_common_code as a inner join webdb.tb_common_code_detail as b on a.code = b.code where a.code = 4";
      json.sex_class_code = await conn.query(query);
      var query = "SELECT b.code_detail, b.code_detail_name FROM webdb.tb_common_code as a inner join webdb.tb_common_code_detail as b on a.code = b.code where a.code = 5";
      json.emd_class_code = await conn.query(query);
      var query = "SELECT b.code_detail, b.code_detail_name FROM webdb.tb_common_code as a inner join webdb.tb_common_code_detail as b on a.code = b.code where a.code = 6";
      json.policy_target_code = await conn.query(query);
      var query = "SELECT b.code_detail, b.code_detail_name FROM webdb.tb_common_code as a inner join webdb.tb_common_code_detail as b on a.code = b.code where a.code = 7";
      json.policy_institution_code = await conn.query(query);
      var query = "SELECT b.code_detail, b.code_detail_name FROM webdb.tb_common_code as a inner join webdb.tb_common_code_detail as b on a.code = b.code where a.code = 8";
      json.policy_field_code = await conn.query(query);
      var query = "SELECT b.code_detail, b.code_detail_name FROM webdb.tb_common_code as a inner join webdb.tb_common_code_detail as b on a.code = b.code where a.code = 9";
      json.policy_character_code = await conn.query(query);
      var query = "select code,code_name from webdb.tb_common_code;"
      json.code_data_name = await conn.query(query);
      return json;
    } catch (error) {
        console.log('codeData-controller getCodeData error:'+error);
    }
};

exports.getCodedetail = async function(req, res) {
  try{
    conn = await db.getConnection();
    var code = req.params.id;
    var query = "SELECT code_detail,code_detail_name FROM webdb.tb_common_code_detail where code = '" + code + "'";
    var rows = await conn.query(query); // 쿼리 실행
    // console.log(rows[1].code_detail);
    // console.log(rows);
    return rows;
  }
  catch(error){
    console.log('codeData-controller getCodedetail error:'+error);
  }
};