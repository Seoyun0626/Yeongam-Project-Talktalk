var db = require('../utils/db');
var bkfd2Password = require('pbkdf2-password');
var hasher = bkfd2Password();
const nodemailer = require("nodemailer");

const { uuid } = require('uuidv4');
// const jwt = require('jsonwebtoken');

// 로그인 확인
exports.SignIn = async function(req) {
  var conn;
try{
  var json = {};
  json.code = 0;
  conn = await db.getConnection();
  console.log('login-service SignIn db getConnection');
  var userid = req.body.userid; //req.body.id -> req.body.userid
  var password = req.body.password;
  // console.log('login-serive SignIn - userid', userid); // kth log
  // console.log('login-serive SignIn - password', password); // kth log
  var query = "SELECT userid, userpw, salt, user_name, user_role FROM webdb.tb_user where userid='" + userid + "' ;";
  var rows = await conn.query(query); // 쿼리 실행 
  if (rows[0]) {
      // 관리자만 접속 가능하도록 처리
      if(rows[0].user_role != 0) {
        json.code = 100;
        json.msg = "관리자만 접속 가능합니다.";
        json.data = {};
        console.log('login-service SignIn - 관리자만 접속 가능합니다.');
        return json;
      }
      //저장된 password 와 hash password 가 같은지를 체크하여 로그인 성공, 실패 처리 
      var userSalt = rows[0].salt;
      var userPass = rows[0].userpw;
      
      return new Promise((resolve, reject) => {
          hasher({
              password: password,
              salt: userSalt
          }, (err, pass, salt, hash) => {
              if (hash != userPass) {
                json.code = 100;
                json.msg = "패스워드 일치하지 않습니다.(운영환경 : ID 및 비밀번호가 일치하지 않습니다)";
                json.data = {};
              } else {
                // console.log('login-service json.code', json.code);
                json.data = rows[0];
              }
              resolve(json);
          });
      });
  } else {
      json.code = 100;
      json.msg = "ID 일치하지 않습니다.";
      json.data = {};
      return json;
  }
} catch(error) {
  console.log('login-service SignIn:'+error);
} finally {
  if (conn) conn.end();
}

};






// 회원가입
exports.signUp = async function(req, res) {
  var resultcode = 0;
  var conn;
  try{
    conn = await db.getConnection();
    // console.log('login-service SignUp db getConnection')
    var userid = req.body.userid;
    var password = req.body.password;
    var password2 = req.body.password2;
    var name = req.body.name;
    var inviteCode = req.body.invite_code;
    var query = "SELECT userid FROM webdb.tb_user where userid='" + userid + "' ;";
    var rows = await conn.query(query); // 쿼리 실행
    if(name=='' || req.body.email=='' || req.body.password=='' || req.body.password2=='') {
      resultcode=100;
      console.log('dataif-service update: empty data');
      return resultcode;
    }
    if(password != password2) {
        // 비밀번호가 일치하지 않음
        console.log('비밀번호가 일치하지 않습니다.');
        resultcode = 100;
        return resultcode;
    }
    console.log(req.body);
    if (rows[0] == undefined) {
        hasher({
            password: password
        }, async (err, pass, salt, hash) => {
          const uidUser = uuid();
          var query = "INSERT INTO webdb.tb_user (uid, userid, userpw, user_name, salt, user_role, user_email, user_type, youthAge_code, parentsAge_code, emd_class_code, sex_class_code) values ('"+uidUser+"', '"+req.body.userid+"','"+hash+"','"+req.body.name+"', '"+salt+"', '"+req.body.user_role+"', '"+req.body.user_email+"', '"+req.body.user_type+"', '"+req.body.youthAge_code+"','"+req.body.parentsAge_code+"', '"+req.body.emd_class_code+"', '"+req.body.sex_class_code+"')";
          var rows = await conn.query(query); // 쿼리 실행
          console.log('회원가입 성공');
        });
    } else {
        // 이미 있음
        console.log('이미 존재하는 아이디입니다.');
        resultcode = 100;
    }
    // invite코드의 유저에 무화과 추가
    if(inviteCode != '') {
      query = "SELECT fig,uid FROM webdb.tb_user where userid='" + inviteCode + "' ;";
      var rows = await conn.query(query); // 쿼리 실행
      if(rows[0] == undefined) {
        console.log('존재하지 않는 코드입니다.');
        resultcode = 100;
        return resultcode;
      }
      // int형식으로 무화과 추가후 varchar로 변환
      rows[0].fig = parseInt(rows[0].fig) + 1;
      rows[0].fig = rows[0].fig.toString();
      query = "UPDATE webdb.tb_user SET fig='"+rows[0].fig+"' WHERE userid='"+inviteCode+"';";
      var figUpdate = await conn.query(query); // 쿼리 실행
      var eid = 1; // 무화과 이벤트 번호, 바꿔야함
      query = "insert into webdb.tb_event_part(eid,uid) values('"+eid+"','"+rows[0].uid+"');";
      // console.log(query);
      var eventPart = await conn.query(query); // 쿼리 실행
    }

  } catch(error) {
    console.log('login-service SignUp:'+error);
  } finally {
    if (conn) conn.end();
  }
  
  return resultcode;
};



exports.getAttendance = async function(req, res) {
  var resultcode = 0;
  var conn;
  try{
    conn = await db.getConnection();
    var userid = req.session.user.data.userid;
    var query = 'SELECT uid FROM webdb.tb_user where userid="'+userid+'"';
    var uid = await conn.query(query); // 쿼리 실행
    var today = new Date().toISOString().slice(0, 10); // 오늘 날짜
    var query = 'SELECT * FROM webdb.tb_attendance_logs where user_uid="'+uid[0].uid+'" and attendance_date="'+today+'"';
    var attendanceLog = await conn.query(query); // 쿼리 실행

    if(attendanceLog.length){
      resultcode = 1;
    } else resultcode = 0;
  } catch(error) {
    console.log('login-service getAttendance:'+error);
  } finally {
    if (conn) conn.end();
  }
  return resultcode;
};

exports.checkAttendance = async function(req, res) {
  var resultcode = 0;
  var conn;
  try{
    conn = await db.getConnection();
    var userid = req.session.user.data.userid;
    var today = new Date(); // 오늘 날짜
    // userid를 통해 uid받아오기
    var query = 'SELECT uid FROM webdb.tb_user where userid="'+userid+'"';
    var uid = await conn.query(query); // 쿼리 실행
    query = 'insert into webdb.tb_attendance_logs (user_uid, attendance_date, attendance_time) values ("'+uid[0].uid+'", "'+today.toISOString().slice(0, 10)+'", "'+today.toISOString().slice(11, 19)+'")';
    var rows = await conn.query(query); // 쿼리 실행
    console.log('출석 체크 완료');
    resultcode = 1;
  } catch(error) {
    console.log('login-service checkAttendance:'+error);
  } finally {
    if (conn) conn.end();
  }
  return resultcode;
};


//로그인 체크
exports.login_check = async function(req, res) {
  var resultcode = 0;
  var conn;
  try{
    conn = await db.getConnection();
    var userid = req.session.user.userid;
    var password = req.session.user.password;
    // console.log(userid, password);
    var query = 'SELECT userpw, salt FROM webdb.tb_user where userid="'+userid+'"';
    var rows = await conn.query(query); // 쿼리 실행
    if(rows.length){
      var user = rows[0];
      return new Promise((resolve,reject)=>{
          hasher( 
            { password: password, salt: user.salt },
            function (err, pass, salt, hash) {
              if (hash === user.userpw) resultcode = 3;
              else resultcode = 2;
              resolve(resultcode);
          });
      });
    } else resultcode = 1;

    return resultcode;
  } catch(error) {
    console.log('login-service login_check:'+error);
  } finally {
    if (conn) conn.end();
  }
};





/*
exports.date_check = async function(req, res) {
  var resultcode = 0;
  var conn;
  try{
    console.log('date_check');
    conn = await db.getConnection();
    var userid = req.user.userid;
    var query = "SELECT case when Timestampdiff(hour, Date_format(Str_to_date(a.strt_date, '%Y%m%d'),'%Y-%m-%d'),now()) >= 0 and Timestampdiff(hour, Date_format(Str_to_date(a.end_date, '%Y%m%d'),'%Y-%m-%d'),now()) <= 0 then "
      +"Timestampdiff(hour, now(), Date_format(Str_to_date(a.end_date, '%Y%m%d'),'%Y-%m-%d')) else 0 end expr"
//      +"when Timestampdiff(hour, Date_format(Str_to_date(a.strt_date, '%Y%m%d'),'%Y-%m-%d'),now()) < 0 and Timestampdiff(hour, Date_format(Str_to_date(a.end_date, '%Y%m%d'),'%Y-%m-%d'),now()) <= 0 then "
//      +"Timestampdiff(hour, now(),Date_format(Str_to_date(a.end_date, '%Y%m%d'),'%Y-%m-%d')) else 0 end expr"
      +", a.strt_date FROM webdb.tb_dataif a inner join webdb.tb_sensor b on a.sensor_board_idx=b.board_idx inner join webdb.tb_device c on b.dev_board_idx=c.board_idx where a.permit_type in ('Y', 'S') and a.ins_id='"+userid+"' and b.sen_mng_no='"+req.body.sensorid+"'";
    var rows = await conn.query(query); // 쿼리 실행
    var expr=0;
    if(rows.length>0) {
      expr=rows[0].expr;
      const token = jwt.sign(
        { userid: userid },
        'eyJ1c2VySWQiOiIxIiwiaWF0IjoxNjMyOTg2',
        { expiresIn: expr });
      if(expr>0) req.user.token=token;
      //req.user.strt_date=rows[0].strt_date;
    }

    return resultcode;
  } catch(error) {
    console.log('login-service date_check:'+error);
  } finally {
    if (conn) conn.end();
  }
};
*/
