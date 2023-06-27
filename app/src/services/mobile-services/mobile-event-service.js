var db = require('../../utils/db');


// 무화과 지급(이벤트 참여)
// tb_event_part에 기록 추가, tb_user의 fig열 update
exports.giveFigForAttendance = async function(req, res) {
  var conn;
  try{
    conn = await db.getConnection();
    // var eid = req.params.eid;
    var uid = req.idPerson;
    var query = `CALL webdb.SP_GIVE_FIG_FOR_ATTENDANCE(?)`;
    var result = await conn.query(query, [uid]);
    // console.log(result);
    return result


  } catch(error) {
    console.log('mobile-event-service giveFig:'+error);
  } finally {
    if(conn) conn.end();
  }
};

exports.giveFigForInvitation = async function(req, res) {
  var conn;
  try {
    conn = await db.getConnection();
    var invite_code = req.body.invite_code;
    var invitee_uid = req.idPerson;
    var query = `CALL webdb.SP_GIVE_FIG_FOR_INVITATION(?,?)`;
    var result = await conn.query(query, [invitee_uid, invite_code]);
    // console.log(result);
    if (result && result.affectedRows > 0 && result.inviter_uid !== null) {
      return 'success'; // 유효한 코드
    } else {
      return 'invalidCode'; // 유효하지 않은 코드
    }
  } catch(error) {
    console.log('mobile-event-service giveFigForInvitation:'+error);
    return 'error';
  } finally {
    if(conn) conn.end();
  }
};



// 출석체크 기록 가져오기
// tb_attendance_log에서 uid로 날짜 return -> frontend에서 day 리스트로 받아 temp_days에 저장

exports.getAttendance = async function(req, res) {
  var resultcode = 0;
  var conn;
  try{
    conn = await db.getConnection();
    var uid = req.idPerson;
    
    // uid를 통해 출석기록 받아오기
    // var query = 'SELECT * FROM webdb.tb_attendance_logs WHERE user_uid = "' + uid + '"';
    var query = 'SELECT DATE_FORMAT(attendance_date, "%Y-%m-%d") AS attendance_date FROM webdb.tb_attendance_logs WHERE user_uid = "' + uid + '"';
    var attendanceLog = await conn.query(query); // 쿼리 실행
    // console.log(attendanceLog);

    if(attendanceLog.length){
      resultcode = 1;
    } else resultcode = 0;
    return attendanceLog;
  } catch(error) {
    console.log('mobile-event-service getAttendance:'+error);
  } finally {
    if (conn) conn.end();
  }
  return resultcode;
};



// 무화과 사용 내역 가져오기
exports.fetchFigUsageByUser = async function(req, res) {
    var conn;
    try{
      conn = await db.getConnection();
      var uid = req.idPerson;
      // query = 'SELECT * FROM webdb.tb_fig_usage where uid="'+uid[0].uid+'"';
      query = 'select fig_usage_no,fig_used_date,product_name,product_cost,product_stock from webdb.tb_fig_usage as a inner join webdb.tb_product as b on a.pid = b.pid where a.uid = "'+uid+'";'
      rows = await conn.query(query); // 쿼리 실행
      return rows;
    } catch(error) {
      console.log('mobile-event-service fetchFigUsageByUser:'+error);
    } finally {
      if (conn) conn.end();
    }
  };

// 무화과 지급 내역(이벤트 참여 내역) 가져오기
exports.fetchFigRewardByUser = async function(req, res) {
  var conn;
  try{
    conn = await db.getConnection();
    var uid = req.idPerson;
    query = 'select event_part_no,acquired_time,event_name,fig_payment from webdb.tb_event_part as a inner join webdb.tb_event as b on a.eid = b.eid where a.uid ="'+uid+'"'; 
    var rows = await conn.query(query); // 쿼리 실행
    // console.log(rows);
    return rows;
  } catch(error) {
    console.log('mobile-event-service fetchFigRewardByUser:'+error);
  } finally {
    if (conn) conn.end();
  }
};
