var db = require('../../utils/db');
var bkfd2Password = require('pbkdf2-password');
var bcrypt = require('bcrypt');
var RowDataPacket = require('mariadb');
const generateJsonWebToken = require('../../lib/generate_jwt');
var hasher = bkfd2Password();
const { v4: uuidv4 } = require('uuid');

// const jwt = require('jsonwebtoken');


// 모바일 로그인
exports.SignIn = async function(req) {
  var conn;
try{
  var json = {};
  json.code = 0;
  // console.log('mobile-login-service : ', req.body);
  const id = req.body['userid'];
  const password = req.body['userpw'];
  // console.log(id, password);

  conn = await db.getConnection();
  console.log('login-service SignIn db getConnection');
  
  // 사용자 정보(아이디, 비밀번호, salt)
  const userdb = await conn.query("SELECT uid, userid, userpw, salt FROM webdb.tb_user where userid= ?;", [id]);
  console.log(userdb[0]);

  if (userdb){
    var userPass = userdb[0].userpw;
    console.log(userPass);
    const passwordMatch = await bcrypt.compareSync(password, userPass);

    if (!passwordMatch){
      json.code = 100;
      json.msg = "비밀번호 일치하지 않습니다.";
      json.data = {};
      return json;
    } else {
      
      json.data = userdb[0];
      return json;
    }
  }else {
    // 아이디 일치 X
    json.code = 100;
    json.msg = "ID 일치하지 않습니다.";
    json.data = {};
    return json;
  }
 
} catch(error) {
  console.log('mobile-login-service SignIn:'+error);
} finally {
  if (conn) conn.end();
}

};

// 모바일 회원가입
exports.signUp = async function(req, res) {
  var resultcode = 0;
  var conn;
  try{
    conn = await db.getConnection();
    console.log('mobile-login-service signUp');
    
    console.log(req.body);
    const {userid,user_name, user_email, userpw, userpw2, user_role, user_type, youthAge_code, parentsAge_code, emd_class_code, sex_class_code} = req.body;
    // var query = "SELECT userid FROM webdb.tb_user where userid='" + userid + "' ;";
    // var rows = await conn.query(query); // 쿼리 실행
    
    if(user_name=='' || user_email=='' || userpw=='' || userpw2=='') {
      resultcode=100;
      console.log('필수 정보를 입력해주세요.');
      return resultcode;
    }
    if(userpw != userpw2) {
        // 비밀번호가 일치하지 않음
        console.log('비밀번호가 일치하지 않습니다.');
        resultcode = 100;
        return resultcode;
    }

    let salt = bcrypt.genSaltSync();
    // console.log(salt);
    const pass = bcrypt.hashSync(userpw, salt);
    var randomNumber = Math.floor(10000 + Math.random() * 90000); // token_temp
    var uid = uuidv4(); // 고유 식별 번호
    // console.log(uid);
    await conn.query(`CALL webdb.SP_REGISTER_USER(?,?,?,?,?,?,?,?,?,?,?,?,?);`, [uid, userid, pass, salt, user_name, user_email, user_role, user_type, youthAge_code, parentsAge_code, sex_class_code, emd_class_code, randomNumber ]);
    
  } catch(error) {
    console.log('mobile-login-service SignUp:'+error);
  } finally {
    if (conn) conn.end();
  }
  
  return resultcode;
};


exports.checkDuplicateID = async function(req, res) {
  var conn;
  var resultcode = 0;

  try {
    conn = await db.getConnection();
    console.log('mobile-login-service checkDuplicateID');
    var id = req.body.userid;
    console.log(id);
    var query = "SELECT userid FROM webdb.tb_user WHERE userid=?;"
    var checkdb = await conn.query(query, [id]);
    console.log(checkdb.length);

    if (checkdb.length > 0){
      resultcode = 100;
      return resultcode;
    } else {
      return resultcode;
    }


  } catch(err){
    console.log('mobile-login-service checkDuplicateId:' + err);
  } finally{
    if(conn) conn.end();
  }
};









// // 로그인
// exports.SignIn = async function(req) {
//   var conn;
// try{
//   var json = {};
//   json.code = 0;
//   conn = await db.getConnection();
//   console.log('login-service SignIn db getConnection');
//   var userid = req.body.userid; //req.body.id -> req.body.userid
//   var userpw = req.body.userpw;
//   console.log(userid, userpw);

//   var query = "SELECT userid, userpw, salt, user_name, user_role FROM webdb.tb_user where userid='" + userid + "' ;";
//   var rows = await conn.query(query); // 쿼리 실행 
//   console.log(rows[0]);
//   if (rows[0]) {
//       // // 관리자만 접속 가능하도록 처리
//       // if(rows[0].user_role != 0) {
//       //   json.code = 100;
//       //   json.msg = "관리자만 접속 가능합니다.";
//       //   json.data = {};
//       //   console.log('login-service SignIn - 관리자만 접속 가능합니다.');
//       //   return json;
//       // }
//       //저장된 password 와 hash password 가 같은지를 체크하여 로그인 성공, 실패 처리 
//       var userSalt = rows[0].salt;
//       var userPass = rows[0].userpw;
      
//       return new Promise((resolve, reject) => {
//           hasher({
//               password: userpw,
//               salt: userSalt
//           }, (err, pass, salt, hash) => {
//               if (hash != userPass) {
//                 json.code = 100;
//                 json.msg = "패스워드 일치하지 않습니다.(운영환경 : ID 및 비밀번호가 일치하지 않습니다)";
//                 json.data = {};
//               } else {
//                 // console.log('login-service json.code', json.code);
//                 json.data = rows[0];
//               }
//               resolve(json);
//           });
//       });
//   } else {
//       json.code = 100;
//       json.msg = "ID 일치하지 않습니다.";
//       json.data = {};
//       return json;
//   }
// } catch(error) {
//   console.log('login-service SignIn:'+error);
// } finally {
//   if (conn) conn.end();
// }

// };

// // 회원가입
// exports.signUp = async function(req, res) {
//   var resultcode = 0;
//   var conn;
//   try{
//     conn = await db.getConnection();
//     // console.log('login-service SignUp db getConnection')
//     var userid = req.body.userid;
//     var password = req.body.userpw;
//     var password2 = req.body.userpw2;
//     var name = req.body.name;
//     var query = "SELECT userid FROM webdb.tb_user where userid='" + userid + "' ;";
//     var rows = await conn.query(query); // 쿼리 실행
//     if(req.body.name=='' || req.body.email=='' || req.body.password=='' || req.body.password2=='') {
//       resultcode=100;
//       console.log('dataif-service update: empty data');
//       return resultcode;
//     }
//     if(password != password2) {
//         // 비밀번호가 일치하지 않음
//         console.log('비밀번호가 일치하지 않습니다.');
//         resultcode = 100;
//         return resultcode;
//     }
//     console.log(req.body);
//     if (rows[0] == undefined) {
//         hasher({
//             password: password
//         }, async (err, pass, salt, hash) => {
//           var query = "INSERT INTO webdb.tb_user (userid, userpw, user_name, salt, user_role, user_email, user_type, youthAge_code, parentsAge_code, emd_class_code, sex_class_code) values ('"+req.body.userid+"','"+hash+"','"+req.body.user_name+"', '"+salt+"', '"+req.body.user_role+"', '"+req.body.user_email+"', '"+req.body.user_type+"', '"+req.body.youthAge_code+"','"+req.body.parentsAge_code+"', '"+req.body.emd_class_code+"', '"+req.body.sex_class_code+"')";
//           var rows = await conn.query(query); // 쿼리 실행
//           console.log('회원가입 성공');
//         });
//     } else {
//         // 이미 있음
//         console.log('이미 존재하는 아이디입니다.');
//         resultcode = 100;
//     }
//   } catch(error) {
//     console.log('login-service SignUp:'+error);
//   } finally {
//     if (conn) conn.end();
//   }
  
//   return resultcode;
// };










    


//로그인 체크
exports.login_check = async function(req, res) {
  var resultcode = 0;
  var conn;
  try{
    conn = await db.getConnection();
    var userid = req.body.userid;
    var password = req.body.password;
    var name = req.body.name;
    var query = 'SELECT password, salt FROM webdb.tb_user where userid="'+userid+'"';
    var rows = await conn.query(query); // 쿼리 실행
    if(rows.length){
      var user = rows[0];
      return new Promise((resolve,reject)=>{
          hasher( 
            { password: password, salt: user.salt },
            function (err, pass, salt, hash) {
              if (hash === user.password) resultcode = 3;
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
