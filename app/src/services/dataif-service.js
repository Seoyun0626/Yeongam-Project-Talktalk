var db = require('../utils/db');
// var s_db = require('../utils/s_db');
var bkfd2Password = require('pbkdf2-password');
const nodemailer = require("nodemailer");
var hasher = bkfd2Password();
const url = require('url');
// const { uuid } = require('uuidv4');
const { v4: uuidv4 } = require('uuid');
var utils = require('../utils/utils');
var fs = require('fs');
const { response } = require('express');


exports.fetchFigUsageByUid = async function(req, res) {
  var conn;
  try{
    conn = await db.getConnection();
    var userid = req.params.id;
    var query = 'SELECT uid FROM webdb.tb_user where userid="'+userid+'"';
    var uid = await conn.query(query); // 쿼리 실행
    // query = 'SELECT * FROM webdb.tb_fig_usage where uid="'+uid[0].uid+'"';
    query = 'select fig_usage_no,fig_used_date,product_name,product_cost,product_stock from webdb.tb_fig_usage as a inner join webdb.tb_product as b on a.pid = b.pid where a.uid = "'+uid[0].uid+'";'
    rows = await conn.query(query); // 쿼리 실행
    return rows;
  } catch(error) {
    console.log('dataif-service fetchFigDataByUid:'+error);
  } finally {
    if (conn) conn.end();
  }
};
exports.fetchEventPartByUid = async function(req, res) {
  var conn;
  try{
    conn = await db.getConnection();
    var userid = req.params.id;
    var query = 'SELECT uid FROM webdb.tb_user where userid="'+userid+'"';
    var uid = await conn.query(query); // 쿼리 실행
    var uid_test = uid[0]['uid'];
    query = 'select a.event_part_no, a.acquired_time, b.event_name, b.fig_payment from webdb.tb_event_part as a inner join webdb.tb_event as b on a.eid = b.eid where a.uid ="'+uid_test+'"'; // "3d06c817-d8ee-43be-be7b-226c0a4d6695";'
    var rows = await conn.query(query); // 쿼리 실행
    return rows;
  } catch(error) {
    console.log('dataif-service fetchEventPartByUid:'+error);
  } finally {
    if (conn) conn.end();
  }
};

// 비밀번호 초기화
exports.resetPW = async function(req, res) {
  var resultcode = 0;
  var conn;
  try{
    conn = await db.getConnection();
    var userid = req.params.id;
    // // 확인 이메일을 보내기 위해 이메일 주소 받아오기r where userid="'+userid+'"';
    var rows = await conn.query(query); // 쿼리 실행
    var email = rows[0].user_email;
    // var uid = rows[0].uid;
    // 임시 비밀번호 생성
    var tempPW = Math.random().toString(36).slice(2);
    // 비밀번호 암호화
    hasher({password:tempPW}, async function(err, pass, salt, hash) {
      if (err) {
        console.log('dataif-service resetPW:'+err);
        response.send({resultcode: resultcode});
      }
      try{
        // 임시 비밀번호로 비밀번호 변경,salt값도 변경
        query = 'UPDATE webdb.tb_user SET userpw="'+hash+'", salt="'+salt+'" WHERE userid="'+userid+'"';
        rows = await conn.query(query); // 쿼리 실행
        resultcode = 1;
        console.log('dataif-service resetPW:'+resultcode);
      } catch(error) {
        console.log('dataif-service resetPW:'+error);
        resultcode = 0;
      } finally {
        if (conn) conn.end();
      }
    });
    // return tempPW;
    let transporter = nodemailer.createTransport({
      service: 'naver',
      host: 'smtp.naver.com',
      port: 587,
      auth: {
          user: process.env.NODEMAILER_USER,
          pass: process.env.NODEMAILER_PASS
      }
        });
        let mailOptions = {
          from: process.env.NODEMAILER_USER,
          to: email,
          subject: '비밀번호 초기화',
          text: '임시 비밀번호는 '+tempPW+'입니다.'
      };
      transporter.sendMail(mailOptions, function(error, info){
        if (error) {
            console.log(error);
        } else {
            console.log('Email sent: ' + info.response);
        }
    });
    return tempPW;
  } catch(error) {
    console.log('dataif-service resetPW:'+error);
    response.send({resultcode: resultcode});
  } finally {
    if (conn) conn.end();
  }
};


exports.fetchData = async function(req, res) {
  var conn;
  try{
    conn = await db.getConnection();
    var query = 'SELECT uid,userid,reg_no,user_name,user_role,user_type,youthAge_code,parentsAge_code,sex_class_code,emd_class_code,user_email,fig,ins_date,upd_date FROM webdb.tb_user';
    rows = await conn.query(query); // 쿼리 실행
    return rows;
  } catch(error) {
    console.log('dataif-service fetchData:'+error);
  } finally {
    if (conn) conn.end();
  }
};


// 회원가입 약관 가져오기
exports.fetchTermData = async function(req, res) {
  var conn;
  try{
    conn = await db.getConnection();
    var query = 'SELECT * FROM webdb.tb_terms';
    var rows = await conn.query(query); // 쿼리 실행
    // console.log(rows);
    return rows;
  } catch(error) {
    console.log('dataif-service fetchTermData:'+error);
  } finally {
    if (conn) conn.end();
  }
};
if(!String.prototype.trim) {
  String.prototype.trim = function () {
    return this.replace(/^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g, '');
  };
}
function addslashes(string) {
    return string.replace(/\\/g, '\\\\').
        replace(/\u0008/g, '\\b').
        replace(/\t/g, '\\t').
        replace(/\n/g, '\\n').
        replace(/\f/g, '\\f').
        replace(/\r/g, '\\r').
        replace(/'/g, '\\\'').
        replace(/"/g, '\\"');
}
function mysql_real_escape_string (str) {
  if (typeof str != 'string')
      return str;

  return str.replace(/[\0\x08\x09\x1a\n\r"'\\\%]/g, function (char) {
      switch (char) {
          case "\0":
              return "\\0";
          case "\x08":
              return "\\b";
          case "\x09":
              return "\\t";
          case "\x1a":
              return "\\z";
          case "\n":
              return "\\n";
          case "\r":
              return "\\r";
          case "\"":
          case "'":
          case "\\":
          case "%":
              return "\\"+char; // prepends a backslash to backslash, percent,
                                // and double/single quotes
      }
  });
}
//다 저장? 업데이트?
exports.updateTermData = async function(req, res) {
  var conn;
  try{
    conn = await db.getConnection();
    var idx = 1;
    var terms = mysql_real_escape_string(req.body.terms);
    var privacy = mysql_real_escape_string(req.body.privacy);
    var query = 'update webdb.tb_terms set terms="'+terms+'", privacy="'+privacy+'" where board_idx="'+idx+'"';
    var rows = await conn.query(query); // 쿼리 실행
    return rows;
  } catch(error) {
    console.log('dataif-service updateTermData:'+error);
  } finally {
    if (conn) conn.end();
  }
};

        
exports.fetchDataUserUpdate = async function(req, res) {
  var conn;
  try{
    conn = await db.getConnection();
    var query = 'SELECT * FROM webdb.tb_user where userid="'+req.params.id+'"';
    var rows = await conn.query(query); // 쿼리 실행
    // console.log(rows[0]);
    return rows;
  } catch(error) {
    console.log('dataif-service fetchDataUserUpdate:'+error);
  } finally {
    if (conn) conn.end();
  }
};



// userid로 데이터 조회
exports.fetchDataByUserid = async function(req, res) {
  var conn;
  try{
    conn = await db.getConnection();
    var searchUser = req.url.split('=')[1]; // url에서 userid 추출
    var query = 'SELECT * FROM webdb.tb_user where userid like "%'+searchUser+'%"';
    var rows = await conn.query(query); // 쿼리 실행
    // console.log(rows[0]);
    return rows;
  } catch(error) {
    console.log('dataif-service fetchDataByUserid:'+error);
  } finally {
    if (conn) conn.end();
  }
};

exports.excelData = async function(req, res,xlData) {
  var conn;
  var query;
  var rows;
  try{
    conn = await db.getConnection();
    //엑셀에 저장된 사용자 수
    var total_length = xlData.length;
    // 엑셀 파일 데이터 DB에 저장
    for(var i=0; i<total_length; i++){
      hasher({
        password: xlData[i].password
      }, async function(err, pass, salt, hash) {
        if (err) throw err;
        // Store the password, salt, and hash in the "db"
        var password = hash;
        var salt = salt;
        const { userid, name, user_role, user_email, user_type, youthAge_code, parentsAge_code, emd_class_code, sex_class_code } = xlData[i];
        var query = "INSERT INTO webdb.tb_user (userid, userpw, name, salt, user_role, user_email, user_type, youthAge_code, parentsAge_code, emd_class_code, sex_class_code) values ('"+userid+"', '"+password+"', '"+name+"', '"+salt+"', '"+user_role+"', '"+user_email+"', '"+user_type+"', '"+youthAge_code+"', '"+parentsAge_code+"', '"+emd_class_code+"', '"+sex_class_code+"')";
        rows = await conn.query(query); // 쿼리 실행
      });
    }
    return rows;
  } catch(error) {
    console.log('dataif-service excelData:'+error);
  } finally {
    if (conn) conn.end();
  }
};

exports.update = async function(req, res) {
  var conn;
  var resultcode=0;
  try{
    conn = await db.getConnection();
    var userid = req.params.id;
    if(req.body.name=='' || req.body.email=='' || req.body.password=='' || req.body.password2=='') {
      resultcode=100;
      console.log('dataif-service update: empty data');
      return resultcode;
    }
    // var query = 'update webdb.tb_user set name="'+req.body.name+'", email="'+req.body.email+'", user_role="'+req.body.user_role+'", age_class_code="'+req.body.age_class_code+'", emd_class_code="'+req.body.emd_class_code+'",';
    if(req.body.password != req.body.password2) {
      resultcode=100;
      console.log('dataif-service update: password not match');
      return resultcode;
    }
    hasher(
      {password:req.body.password}, async function(err, pass, salt, hash) {
        const uidUser = uuidv4();
        var query = 'update webdb.tb_user set uid = "'+uidUser+'", userpw="'+hash+'", salt="'+salt+'", user_name="'+req.body.name+'", user_email="'+req.body.user_email+'", user_role="'+req.body.user_role+'", user_type="'+req.body.user_type+'", emd_class_code="'+req.body.emd_class_code+'", youthAge_code = "'+req.body.youthAge_code+'", parentsAge_code = "'+req.body.parentsAge_code+'" where userid="'+userid+'"';
        var rows = await conn.query(query);
      }
    );
    return resultcode;
  } catch(error) {
    console.log('dataif-service update:'+error);
  } finally {
    if (conn) conn.end();
  }
};
exports.deleteUser = async function(req, res) {
  var conn;
  try{
    conn = await db.getConnection();
    console.log('dataif-service delete:'+req.params.id);
    var user_uid = await conn.query("select uid from webdb.tb_user where userid='"+req.params.id+"';");
    var user_uid = user_uid[0].uid;
    var query = "DELETE FROM webdb.tb_policy_scrap where user_uid='"+user_uid+"';";
    var rows = await conn.query(query);
    var query = 'delete from webdb.tb_user where userid="'+req.params.id+'"';
    console.log(query);
    var rows = await conn.query(query);
    return rows;
  } catch(error) {
    console.log('dataif-service delete:'+error);
  } finally {
    if (conn) conn.end();
  }
};


