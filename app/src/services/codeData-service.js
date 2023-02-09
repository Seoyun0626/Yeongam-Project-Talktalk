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
}


exports.getEmdClassCode = async function(req, res) {
    var resultcode = 0;
    var conn;
    try{
      conn = await db.getConnection();
      var query = "SELECT emd_class_code,emd_class_name FROM webdb.tb_emd_class_code";
      var rows = await conn.query(query); // 쿼리 실행
      return rows;
    } catch(error) {
      console.log('code-service getEmdClassCode:'+error);
    } finally {
      if (conn) conn.end();
    }
  };

  exports.getUserType = async function(req, res) {
    var resultcode = 0;
    var conn;
    try{
      conn = await db.getConnection();
      var query = "SELECT user_type,user_type_name FROM webdb.tb_user_type";
      var rows = await conn.query(query); // 쿼리 실행
      return rows;
    } catch(error) {
      console.log('code-service getUserType:'+error);
    } finally {
      if (conn) conn.end();
    }
  };
  
  exports.getParentsAgeCode = async function(req, res) {
    var resultcode = 0;
    var conn;
    try{
      conn = await db.getConnection();
      var query = "SELECT parentsAge_code,parentsAge_name FROM webdb.tb_parentsAge_code";
      var rows = await conn.query(query); // 쿼리 실행
      return rows;
    } catch(error) {
      console.log('code-service getParentsAgeCode:'+error);
    } finally {
      if (conn) conn.end();
    }
  };
  
  exports.getYouthAgeCode = async function(req, res) {
    var resultcode = 0;
    var conn;
    try{
      conn = await db.getConnection();
      var query = "SELECT youthAge_code,youthAge_name FROM webdb.tb_youthAge_code";
      var rows = await conn.query(query); // 쿼리 실행
      return rows;
    } catch(error) {
      console.log('code-service getYouthAgeCode:'+error);
    } finally {
      if (conn) conn.end();
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