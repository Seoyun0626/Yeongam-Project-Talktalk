var db = require('../../utils/db');
const path = require("path");

exports.getBannerData = async function(req, res) {
    var conn;
    try{
        conn = await db.getConnection();
        // console.log('policy-service getBannerData db getConnection');
        var query = "SELECT banner_name, banner_img, banner_link FROM webdb.tb_banner;";
        var rows = await conn.query(query); // 쿼리 실행
        // console.log(rows);
        return rows;
    } catch(error) {
        console.log('policy-service fetchBannerData:'+error);
    } finally {
        if (conn) conn.release();
      }
};