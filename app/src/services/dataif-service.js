var db = require('../utils/db');
// var s_db = require('../utils/s_db');
var bkfd2Password = require('pbkdf2-password');
const nodemailer = require("nodemailer");
var hasher = bkfd2Password();
const url = require('url');
const { uuid } = require('uuidv4');
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
    query = 'select fig_usage_no,fig_used_date,product_name,product_cost,product_desc,product_stock from webdb.tb_fig_usage as a inner join webdb.tb_product as b on a.pid = b.pid where a.uid = "'+uid[0].uid+'";'
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
    query = 'select event_part_no,aquired_time,event_name,event_desc,fig_payment from webdb.tb_event_part as a inner join webdb.tb_event as b on a.eid = b.eid where a.uid = "3d06c817-d8ee-43be-be7b-226c0a4d6695";'
    console.log(query);
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
    // url에서 userid 받아오기 params.id
    var userid = req.params.id;
    // // 확인 이메일을 보내기 위해 이메일 주소 받아오기
    var query = 'SELECT user_email,uid FROM webdb.tb_user where userid="'+userid+'"';
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
    //페이지 설정
    /*
    var start = 0;
    var page=0;
    var pageSize=10;
    var reqpage=req.query.page;
    var reqpageSize=req.query.pageSize;
    var reqsrchword=req.query.srchword;
    if(reqpage!=undefined) page=reqpage;
    if(reqpageSize!=undefined) pageSize=reqpageSize;
    if (page <= 0) page = 1;
    else start = (page - 1) * pageSize;
    var query = 'SELECT count(*) cnt FROM webdb.tb_dataif a inner join webdb.tb_sensor b on a.sensor_board_idx=b.board_idx left outer join webdb.tb_file c'
                +' on c.board_type="tb_dataif" and c.board_idx=a.board_idx where a.ins_id="'+req.user.userid+'"';

    var rows = await conn.query(query);
    var totalPages=Math.ceil(rows[0].cnt / pageSize);
    if (page > totalPages) {
      var rtn=[];
      rtn.totalPages=totalPages;
      rtn.page=page;
      return rtn;
    }
    */

    // query = `SELECT a.*, sen_mng_no, file_type, file_no, board_type, `
    //             +`case when permit_type="N" then "사용자요청" when permit_type="U" then "소유자허가" when permit_type="Y" then "연계준비중" when permit_type="S" then "연계중" when permit_type="E" then "연계완료" end permit_type_nm`
    //             +` FROM webdb.tb_dataif a inner join webdb.tb_sensor b on a.sensor_board_idx=b.board_idx left outer join webdb.tb_file c`
    //             +` on c.board_type="tb_dataif" and c.board_idx=a.board_idx where a.ins_id="${req.user.userid}" order by a.board_idx desc LIMIT ${start}, ${pageSize}`;
    var query = 'SELECT * FROM webdb.tb_user';
    rows = await conn.query(query); // 쿼리 실행
  // rows.totalPages=totalPages;
  // rows.page=page;
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
    console.log(rows);
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
    var searchUser = req.url.split('=')[1]; //바꿔야 하나?
    // console.log(searchUser);
    // if(req.params.id==undefined || req.url.split('?')[1].split('=')[0] == "search") req.params.id=req.url.split('/')[1].split('=')[1];
    var query = 'SELECT * FROM webdb.tb_user where userid="'+searchUser+'"';
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
        var userid = xlData[i].userid;
        var password = hash;
        var name = xlData[i].name;
        var salt = salt;
        var user_role = xlData[i].user_role;
        var user_email = xlData[i].user_email;
        var user_type = xlData[i].user_type;
        var youthAge_code = xlData[i].youthAge_code;
        var parentsAge_code = xlData[i].parentsAge_code;
        var emd_class_code = xlData[i].emd_class_code;
        var sex_class_code = xlData[i].sex_class_code;
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
      
    


exports.fetchDataSensor = async function(req, res) {
  var conn;
  try{
    conn = await db.getConnection();

    var usertype=req.user.user_type;

    var start = 0;
    var page=0;
    var pageSize=10;
    var reqpage=req.query.page;
    var reqpageSize=req.query.pageSize;
    var reqsrchword=req.query.srchword;
    if(reqpage!=undefined) page=reqpage;
    if(reqpageSize!=undefined) pageSize=reqpageSize;
    if (page <= 0) page = 1;
    else start = (page - 1) * pageSize;
    console.log('dataif-service fetchDataSensor:'+req.user.userid);
    var query;
    if(usertype=="9") query = 'SELECT count(*) cnt FROM webdb.tb_dataif a inner join webdb.tb_sensor b on a.sensor_board_idx=b.board_idx left outer join webdb.tb_file c on c.board_type="tb_dataif" and c.board_idx=a.board_idx';
    else query = 'SELECT count(*) cnt FROM webdb.tb_dataif a inner join webdb.tb_sensor b on a.sensor_board_idx=b.board_idx left outer join webdb.tb_file c on c.board_type="tb_dataif" and c.board_idx=a.board_idx where b.ins_id="'+req.user.userid+'"'; 
    var rows = await conn.query(query);
    var totalPages=Math.ceil(rows[0].cnt / pageSize);
    if (page > totalPages) {
      var rtn=[];
      rtn.totalPages=totalPages;
      rtn.page=page;
      return rtn;
    }

    var query;
    if(usertype=="9") query = `SELECT a.*, sen_mng_no, file_type, file_no, b.ins_id sen_ins_id,`
      +` case when permit_type="N" then "사용자요청" when permit_type="U" then "소유자허가" when permit_type="Y" then "연계준비중" when permit_type="S" then "연계중" when permit_type="E" then "연계완료" end permit_type_nm`
      +` FROM webdb.tb_dataif a inner join webdb.tb_sensor b on a.sensor_board_idx=b.board_idx left outer join webdb.tb_file c on c.board_type="tb_dataif" and c.board_idx=a.board_idx order by a.board_idx desc LIMIT ${start}, ${pageSize}`;
    else query = `SELECT a.*, sen_mng_no, file_type, file_no, b.ins_id sen_ins_id, case when permit_type="N" then "사용자요청" when permit_type="U" then "소유자허가" when permit_type="Y" then "연계준비중" when permit_type="S" then "연계중" when permit_type="E" then "연계완료" end permit_type_nm FROM webdb.tb_dataif a inner join webdb.tb_sensor b on a.sensor_board_idx=b.board_idx left outer join webdb.tb_file c on c.board_type="tb_dataif" and c.board_idx=a.board_idx where b.ins_id="${req.user.userid}" order by a.board_idx desc LIMIT ${start}, ${pageSize}`; 
    rows = await conn.query(query); // 쿼리 실행

    rows.totalPages=totalPages;
    rows.page=page;

    return rows;
  } catch(error) {
    console.log('dataif-service fetchDataSensor:'+error);
  } finally {
    if (conn) conn.end();
  }
};

exports.retrieveData = async function(req, res) {
  var conn;
  try{
    conn = await db.getConnection();

    var query = 'SELECT a.*, b.sen_mng_no, c.sen_name, c.sen_grp, c.prj_grp, d.name FROM webdb.tb_dataif a inner join webdb.tb_sensor b on a.sensor_board_idx=b.board_idx inner join webdb.tb_device c on b.dev_board_idx=c.board_idx inner join webdb.tb_user d on a.ins_id=d.userid where a.board_idx='+req.params.id;
    var rows = await conn.query(query); // 쿼리 실행

    return rows[0];
  } catch(error) {
    console.log('dataif-service retrieveData:'+error);
  } finally {
    if (conn) conn.end();
  }
};

exports.create = async function(req, res) {
  var conn;
  try{
    conn = await db.getConnection();
    await conn.beginTransaction() // 트랜잭션 적용 시작

    var query;
    var rows;
    var queryStr;

    var senIdx=req.body.sensor_board_idx;
    var arrsensorboardidx=[];
    if(typeof senIdx=='object') arrsensorboardidx=senIdx;
    else arrsensorboardidx.push(senIdx);

    if(req.body.if_type=="DBS") req.body.fieldArr=['dbname', 'end_date', 'hostip', 'if_subtype', 'if_type', 'password', 'port', 'req_dtl', 'sensor_board_idx', 'strt_date', 'tbname', 'userid', 'ins_id'];
    else if(req.body.if_type=="COM")
      if(req.body.if_subtype=="MQT") req.body.fieldArr=['end_date', 'if_subtype', 'if_type', 'req_dtl', 'sensor_board_idx', 'strt_date', 'ins_id'];
      else if(req.body.if_subtype=="WEB") req.body.fieldArr=['end_date', 'if_subtype', 'if_type', 'req_dtl', 'sensor_board_idx', 'strt_date', 'ins_id'];

    for(idx in arrsensorboardidx){
      req.body.sensor_board_idx=arrsensorboardidx[idx];
      //query = 'select count(board_idx) cnt from webdb.tb_sensor where ins_id="'+req.user.userid+'" and board_idx='+arrsensorboardidx[idx];
      //rows = await conn.query(query);
      queryStr=utils.makeInsertFieldQuery(req);
      /*if(rows[0].cnt>0) {
        if(req.body.if_type=="DBS") query = 'insert into webdb.tb_dataif (dbname, end_date, hostip, if_subtype, if_type, password, port, req_dtl, sensor_board_idx, strt_date, tbname, userid, ins_id, permit_type) values ('+queryStr+', "Y")';
        else if(req.body.if_type=="COM")
          if(req.body.if_subtype=="MQT") query = 'insert into webdb.tb_dataif (end_date, hostip, if_subtype, if_type, port, req_dtl, sensor_board_idx, strt_date, tbname, ins_id, permit_type) values ('+queryStr+', "Y")';
          else if(req.body.if_subtype=="WEB") query = 'insert into webdb.tb_dataif (end_date, hostip, if_subtype, if_type, port, req_dtl, sensor_board_idx, strt_date, ins_id, permit_type) values ('+queryStr+', "Y")';
        rows = await conn.query(query);
      } else {*/
        if(req.body.if_type=="DBS") query = 'insert into webdb.tb_dataif (dbname, end_date, hostip, if_subtype, if_type, password, port, req_dtl, sensor_board_idx, strt_date, tbname, userid, ins_id) values ('+queryStr+')';
        else if(req.body.if_type=="COM")
          if(req.body.if_subtype=="MQT") query = 'insert into webdb.tb_dataif (end_date, if_subtype, if_type, req_dtl, sensor_board_idx, strt_date, ins_id) values ('+queryStr+')';
          else if(req.body.if_subtype=="WEB") query = 'insert into webdb.tb_dataif (end_date, if_subtype, if_type, req_dtl, sensor_board_idx, strt_date, ins_id) values ('+queryStr+')';
        rows = await conn.query(query);
      //}
    }
    await conn.commit() // 커밋

    query = 'select sen_mng_no, b.sen_name, a.ins_id from webdb.tb_sensor a inner join webdb.tb_device b on a.dev_board_idx=b.board_idx where a.board_idx='+req.body.sensor_board_idx;
    rows = await conn.query(query);
    req.body.from=req.user.userid;
    if(rows[0].ins_id=='1') req.body.to='jaipl@naver.com';
    else req.body.to=rows[0].ins_id;
    req.body.subject=rows[0].sen_name+"("+rows[0].sen_mng_no+")의 데이터연계 사용허가를 요청합니다.";
    req.body.text=req.body.req_dtl+'\r\n\r\n https://swiu_testbed.dongguk.edu 접속해서 "데이터연계 사용허가 관리" 메뉴에서 내용을 확인하시기 바랍니다.';
    utils.sendEmail(req);

    return rows;
  } catch(error) {
    if (conn) await conn.rollback(); // 롤백
    //return res.status(500).json(err)
    console.log('dataif-service create:'+error);
  } finally {
    if (conn) conn.release();
  }
};

exports.update = async function(req, res) {
  var conn;
  var resultcode=0;
  try{
    conn = await db.getConnection();
    // ??
    // if(req.body.if_type!="DBS") {
    //   req.body.hostip='';
    //   req.body.port='';
    //   req.body.userid='';
    //   req.body.password='';
    //   req.body.dbname='';
    //   req.body.tbname='';
    // }
    // req.body.fieldArr=['dbname', 'end_date', 'hostip', 'if_subtype', 'if_type', 'password', 'port', 'req_dtl', 'sensor_board_idx', 'strt_date', 'tbname', 'userid'];
    // var queryStr=utils.makeBoardUpdateFieldQuery(req.body);
    // 'update webdb.tb_dataif set data_cnt='+req.body.count+' where board_idx='+req.body.modal_board_idx;
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
        // query += 'password="'+hash+'", salt="'+salt+'" where userid="'+userid+'"';
        const uidUser = uuid();
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

exports.giveFig = async function(req, res) {
  var conn;
  try{
    conn = await db.getConnection();
    // tb_user에서 fig값을 받아오기
    var query = 'select fig from webdb.tb_user where userid="'+req.params.id+'"';
    var originFig = await conn.query(query);
    var giveFig = url.parse(req.url, true);
    // console.log(url_parts.query.fig);
    // console.log(originFig[0].fig);
    // 두 값을 더해서 tb_user에 업데이트
    var newFig = parseInt(originFig[0].fig) + parseInt(giveFig.query.fig);
    query = 'update webdb.tb_user set fig='+newFig+' where userid="'+req.params.id+'"';
    var rows = await conn.query(query);
    return rows;
  } catch(error) {
    console.log('dataif-service giveFig:'+error);
  } finally {
    if(conn) conn.end();
  }
};

exports.retrieveDataProject = async function(req, res) {
  var conn;
  try{
    conn = await db.getConnection();
    var query = 'SELECT * FROM webdb.tb_dataif where prj_board_idx='+req.params.id;
    var rows = await conn.query(query); // 쿼리 실행
    var post=rows;
    /*
    for(var idx=0;idx<post.length;idx++){
      query = 'SELECT file_type, file_no, mime_type, org_file_name, file_size, file_path, board_type FROM webdb.tb_file where board_type="tb_dataif" and board_idx='+post[idx].board_idx;
      rows = await conn.query(query); // 쿼리 실행
      var file={};
      var flearr=['file_type', 'file_no', 'mime_type', 'org_file_name', 'file_size', 'file_path', 'board_type'];
      var fileNo=0;
      var file_type='';
      for(var idx=0;idx<rows.length;idx++){
        var rowdata=rows[idx];
        for(key in rowdata){
            if(key=='file_type') file_type=rowdata[key];
            if(flearr.indexOf(key)>-1 && file_type=='img') post[key]=rowdata[key];
            else file[key]=rowdata[key];
          }
        if(fileNo==0) post.file=[];
        if(file.file_type) post.file.push(file);
        fileNo++;
        file={};
      }
    }
*/
    return post;
  } catch(error) {
    console.log('dataif-service retrieveDataProject:'+error);
  } finally {
    if (conn) conn.end();
  }
};

exports.permit = async function(req, res) {
  var conn;
  try{
    conn = await db.getConnection();
    var query ;
    var permit_type=req.query.permit_type;
    var sen_ins_id=req.query.sen_ins_id;
    var sen_grp=req.query.sen_grp;
    if(req.user.user_type=="9")
      if(permit_type=="Y")
        if(sen_ins_id==req.user.userid) query = 'update webdb.tb_dataif set permit_type="N" ';
        else query = 'update webdb.tb_dataif set permit_type="U" ';
      else query = 'update webdb.tb_dataif set permit_type="Y" ';
    else
      if(permit_type=="U") query = 'update webdb.tb_dataif set permit_type="N" ';
      else query = 'update webdb.tb_dataif set permit_type="U" ';
      
    if(req.query.if_type=="COM"){
      if(sen_grp=="0001") query += ', hostip="210.94.199.140" ';
      else if(sen_grp=="0002" || sen_grp=="0003") query += ', hostip="210.94.199.225" ';
      if(req.query.if_subtype=="WEB") query += ', port="3233" ';
      else query += ', port="1883" ';
    }
    query += 'where board_idx='+req.query.board_idx;
    var rows = await conn.query(query); // 쿼리 실행

    return rows;
  } catch(error) {
    console.log('dataif-service permit:'+error);
  } finally {
    if (conn) conn.end();
  }
};

exports.getClass = async function(req, res) {
  var conn;
  try{
    conn = await db.getConnection();

    var senIdx=req.body.sensor_board_idx;
    var arrsensorboardidx=[];
    var whereStr;
    var queryStr='';
    if(typeof senIdx=='object') arrsensorboardidx=senIdx;
    else arrsensorboardidx.push(senIdx);

    for(idx in arrsensorboardidx)
      queryStr += '"'+arrsensorboardidx[idx] + '",';
    queryStr=queryStr.substr(0,queryStr.length-1);
    if(arrsensorboardidx.length==1) whereStr='b.board_idx="'+queryStr+'"';
    else whereStr='b.board_idx in ('+queryStr+')';

    var query = 'SELECT a.sen_grp, a.prj_grp, b.sen_id FROM webdb.tb_device a inner join webdb.tb_sensor b on a.board_idx=b.dev_board_idx where '+whereStr;
    var rows = await conn.query(query); // 쿼리 실행
    var post=rows;

    return post;
  } catch(error) {
    console.log('dataif-service getClass:'+error);
  } finally {
    if (conn) conn.end();
  }
};

// exports.s_getCount = async function(req, res) {
//   var conn;
//   try{
//     conn = await s_db.getConnection();
    
//     var senId=req.body.s_senId;
//     var arrsenId=[];
//     var whereStr;
//     var queryStr='';
//     if(typeof senId=='object') arrsenId=senId;
//     else arrsenId.push(senId);

//     for(idx in arrsenId)
//       queryStr += '"'+arrsenId[idx] + '",';
//     queryStr=queryStr.substr(0,queryStr.length-1);
//     if(arrsenId.length==1) whereStr='senid="'+queryStr+'"';
//     else whereStr='senid in ('+queryStr+')';

//     var query = 'SELECT count(senid) cnt, senid FROM appdb.sensor where '+whereStr+' and sendatetime between date("'+utils.to_date_format(req.body.strt_date,'-')+'") and date("'+utils.to_date_format(req.body.end_date,'-')+'") group by senid';
//     var rows = await conn.query(query); // 쿼리 실행
//     var post=rows;

//     return post;
//   } catch(error) {
//     console.log('dataif-service s_getCount:'+error);
//   } finally {
//     if (conn) conn.end();
//   }
// };

exports.getCount = async function(req, res) {
  var conn;
  try{
    conn = await db.getConnection();

    var senId=req.body.senId;
    var arrsenId=[];
    var whereStr;
    var queryStr='';
    if(typeof senId=='object') arrsenId=senId;
    else arrsenId.push(senId);

    for(idx in arrsenId)
      queryStr += '"'+arrsenId[idx] + '",';
    queryStr=queryStr.substr(0,queryStr.length-1);
    if(arrsenId.length==1) whereStr='senid="'+queryStr+'"';
    else whereStr='senid in ('+queryStr+')';

    var query = 'SELECT count(senid) cnt, senid FROM appdb.sensor where '+whereStr+' and sendatetime between date("'+utils.to_date_format(req.body.strt_date,'-')+'") and date("'+utils.to_date_format(req.body.end_date,'-')+'") group by senid';
    var rows = await conn.query(query); // 쿼리 실행
    var post=rows;

    return post;
  } catch(error) {
    console.log('dataif-service getCount:'+error);
  } finally {
    if (conn) conn.end();
  }
};

exports.setCount = async function(req, res) {
  var conn;
  try{
    conn = await db.getConnection();
    var query = 'update webdb.tb_dataif set data_cnt='+req.body.count+' where board_idx='+req.body.modal_board_idx;
    var rows = await conn.query(query); // 쿼리 실행

    return rows;
  } catch(error) {
    console.log('dataif-service setCount:'+error);
  } finally {
    if (conn) conn.end();
  }
};