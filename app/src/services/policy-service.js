var db = require('../utils/db');
var multer = require('multer');
const path = require("path");

exports.fetchData = async function(req, res) {
    var conn;
    try{
        conn = await db.getConnection();
        console.log('policy-service fetchData db getConnection');
        var query = "SELECT * FROM webdb.tb_policy;";
        var rows = await conn.query(query); // 쿼리 실행
        return rows;
    } catch(error) {
        console.log('policy-service fetchData:'+error);
    } finally {
        conn.release();
    }
}



exports.upload = async function(req, res) {
    var conn;
    var resultcode = 0;
    try{
        var temp = Date.now();
        // 이미지 업로드
        var upload = multer({ 
            storage: multer.diskStorage({
                destination: function (req, file, cb) {
                    cb(null, '../frontend/images/policy');
                },
                filename: function (req, file, cb) {
                    temp = temp + path.extname(file.originalname);
                    cb(null, temp);
                }
            })
        }).single('imgFile');
        upload(req, res, function (err) {
            if (err instanceof multer.MulterError) {
                console.log('multer error:' + err);
            } else if (err) {
                console.log('multer error:' + err);
            }
        });
        conn = await db.getConnection();
        console.log('policy-service upload db getConnection');
        var name = req.body.name;
        var target = req.body.target;
        var supervision = req.body.supervision;
        var description = req.body.description;
        var fund = req.body.fund;
        var content = req.body.content;
        var query = "INSERT INTO webdb.tb_policy (policy_name, policy_target, policy_supervision, description, fund, content, img) VALUES ('" + name + "', '" + target + "', '" + supervision + "', '" + description + "', '" + fund + "', '" + content + "', '" + temp + "');";
        var rows = await conn.query(query); // 쿼리 실행
        console.log('policy-service upload success');
        return resultcode; //0이면 성공
    } catch(error) {
        console.log('policy-service upload:'+error);
        resultcode = 100;
    } finally {
        if (conn) conn.end();
    }
};


let banner_storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, '../frontend/images/policy');
    },
    filename: function (req, file, cb) {
        // cb(null, file.originalname);
        cb(null, Date.now() + path.extname(file.originalname));
    }
});

exports.banner = async function(req, res) {
    var conn;
    var resultcode = 0;
    try{
        var temp = Date.now();
        // 이미지 업로드
        var upload = multer({ 
            storage: multer.diskStorage({
                destination: function (req, file, cb) {
                    cb(null, '../frontend/images/banner');
                },
                filename: function (req, file, cb) {
                    temp = temp + path.extname(file.originalname);
                    cb(null, temp);
                }
            })}).single('imgFile');
        upload(req, res, function (err) {
            if (err instanceof multer.MulterError) {
                console.log('multer error:'+err);
            } else if (err) {
                console.log('multer error:'+err);
            }
        });

        conn = await db.getConnection();
        console.log('policy-service banner db getConnection');
        var name = req.body.name;
        var link = req.body.link;
        var query = "INSERT INTO webdb.tb_banner (banner_name, img, link) VALUES ('" + name + "', '" + temp + "', '" + link + "');";
        var rows = await conn.query(query); // 쿼리 실행
        console.log('policy-service banner success');
        return resultcode; //0이면 성공
    } catch(error) {
        console.log('policy-service banner:'+error);
        resultcode = 100;
    }
};