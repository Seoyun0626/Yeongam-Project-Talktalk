var db = require('../../utils/db');


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
  exports.fetchFigRewardByUser = async function(req, res) {
    var conn;
    try{
      conn = await db.getConnection();
      var uid = req.idPerson;
      query = 'select event_part_no,acquired_time,event_name,fig_payment from webdb.tb_event_part as a inner join webdb.tb_event as b on a.eid = b.eid where a.uid ="'+uid+'"'; // "3d06c817-d8ee-43be-be7b-226c0a4d6695";'
      var rows = await conn.query(query); // 쿼리 실행
      // console.log(rows);
      return rows;
    } catch(error) {
      console.log('mobile-event-service fetchFigRewardByUser:'+error);
    } finally {
      if (conn) conn.end();
    }
  };