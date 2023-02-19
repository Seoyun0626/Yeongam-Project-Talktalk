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
};


//policy-upload창에서 필요한 코드 정보들 가져오기
exports.fetchCodeData = async function(req, res) {
    var conn;
    try{
        conn = await db.getConnection();
        console.log('policy-service fetchCodeData db getConnection');
        var query = "SELECT * FROM webdb.tb_policy_target_code,tb_policy_institution_code except  board_idx;";
        var rows = await conn.query(query); // 쿼리 실행
        return rows;
    } catch(error) {
        console.log('policy-service fetchCodeData:'+error);
    } finally {
        conn.release();
    }
};

exports.fetchpolicyByidx = async function(req, res) {
    var conn;
    try{
      conn = await db.getConnection();
      var query = 'SELECT * FROM webdb.tb_policy where board_idx="'+req.params.id+'"';
      var rows = await conn.query(query); // 쿼리 실행
    //   console.log(rows[0]);
      return rows;
    } catch(error) {
      console.log('dataif-service fetchpolicyByidx:'+error);
    } finally {
      if (conn) conn.end();
    }
  };

exports.updatePolicy = async function(req, res) {
    var conn;
    var resultcode = 0;
    try{
        var temp = Date.now();
        // 이미지 업로드
        var upload = multer({ 
            storage: multer.diskStorage({
                destination: function (req, file, cb) {
                    cb(null, '../frontend/images/policy');
                    // cb(null, '../app/src/public/upload/policy');
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
        // DB에 저장
        conn = await db.getConnection();
        console.log('policy-service updatePolicy db getConnection');
        var query = "UPDATE webdb.tb_policy SET img='"+temp+"', policy_name='"+req.body.name+"', content='"+req.body.content+"', fund='"+req.body.fund+"', policy_target_code='"+req.body.target+"', policy_institution_code='"+req.body.policy_institution_code+"', application_start_date='"+req.body.application_start_date+"', application_end_date='"+req.body.application_end_date+"', policy_field_code='"+req.body.policy_field_code+"', policy_character_code='"+req.body.policy_character_code+"', policy_institution_code='"+req.body.policy_institution_code+"' where board_idx='"+req.params.id+"';";
        var rows = await conn.query(query); // 쿼리 실행
        return resultcode;
    } catch(error) {
        console.log('policy-service updatePolicy:'+error);
        resultcode = 1;
    } finally {
        conn.release();
    }
};

exports.deletePolicy = async function(req, res) {
    var conn;
    try{
        conn = await db.getConnection();
        console.log('policy-service deletePolicy db getConnection');
        var query = "DELETE FROM webdb.tb_policy where board_idx='"+req.params.id+"';";
        var rows = await conn.query(query); // 쿼리 실행
        return rows;
    } catch(error) {
        console.log('policy-service deletePolicy:'+error);
    } finally {
        conn.release();
    }
};

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
                    // cb(null, '../app/src/public/upload/policy');
                    
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
        // DB에 저장
        conn = await db.getConnection();
        console.log('policy-service upload db getConnection');
        var name = req.body.name;
        var target = req.body.target;
        var policy_institution_code = req.body.policy_institution_code;
        var description = req.body.description;
        var fund = req.body.fund;
        var content = req.body.content;
        var application_start_date = req.body.application_start_date;
        var application_end_date = req.body.application_end_date;
        var policy_field_code = req.body.policy_field_code;
        var policy_character_code = req.body.policy_character_code;
        if(name == null || name == undefined || name == '') {
            resultcode = 1;
            return resultcode;
        }
        if(description == null || description == undefined || description == '') {
            resultcode = 2;
            return resultcode;
        }
        if(fund == null || fund == undefined || fund == '') {
            resultcode = 3;
            return resultcode;
        }
        // if(content == null || content == undefined || content == '') {
        //     resultcode = 4;
        //     return resultcode;
        // }
        if(application_start_date == null || application_start_date == undefined || application_start_date == '') {
            resultcode = 5;
            return resultcode;
        }
        if(application_end_date == null || application_end_date == undefined || application_end_date == '') {
            resultcode = 6;
            return resultcode;
        }
        // if(content == null || content == undefined || content == '') {
        //     resultcode = 7;
        //     return resultcode;
        // }
        var query = "INSERT INTO webdb.tb_policy (policy_name, policy_target_code, policy_institution_code, description, fund, content, img, application_start_date, application_end_date, policy_field_code, policy_character_code) VALUES "
          + "('" + name + "', '" + target + "', '" + policy_institution_code + "', '" + description + "', '" + fund + "', '" + content + "', '" + temp + "', '" + application_start_date + "', '" + application_end_date + "', '" + policy_field_code + "', '" + policy_character_code + "');";
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
                    // cb(null, '../app/src/public/upload/banner');
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
        console.log('policy-service banner db getConnection:', req.body);
        // console.log(req.body);
        var name = req.body.name;
        var link = req.body.link;
        var query = "INSERT INTO webdb.tb_banner (banner_name, banner_img, banner_link) VALUES ('" + name + "', '" + temp + "', '" + link + "');";
        var rows = await conn.query(query); // 쿼리 실행
        console.log('policy-service banner success');
        return resultcode; //0이면 성공
    } catch(error) {
        console.log('policy-service banner:'+error);
        resultcode = 100;
    }
};
exports.fetchBannerData = async function(req, res) {
    var conn;
    try{
        conn = await db.getConnection();
        console.log('policy-service fetchBannerData db getConnection');
        var query = "SELECT * FROM webdb.tb_banner;";
        var rows = await conn.query(query); // 쿼리 실행
        return rows;
    } catch(error) {
        console.log('policy-service fetchBannerData:'+error);
    } finally {
        conn.release();
    }
};

exports.deleteBanner = async function(req, res) {
    var conn;
    var resultcode = 0;
    try{
        conn = await db.getConnection();
        var query = 'delete from webdb.tb_banner where board_idx="'+req.params.id+'"';
        var rows =  await conn.query(query); // 쿼리 실행
        console.log('policy-service deleteBanner success');
        return resultcode; //0이면 성공
    } catch(error) {
        console.log('policy-service deleteBanner:'+error);
        resultcode = 100;
    } finally {
        conn.release();
    }
};


exports.getAllPolicy = async function(req, res) {
    var conn;
    try{
        conn = await db.getConnection();
        console.log('policy-service getAllPolicy db getConnection');
        var query = "SELECT * FROM webdb.tb_policy;";
        var rows = await conn.query(query); // 쿼리 실행
        // console.log(rows[0]);
        // console.log(rows[1]);
        // console.log(rows[2]); 
        console.log(rows);
        return rows;
    } catch(error) {
        console.log('policy-service getAllPolicy:'+error);
    } finally {
        conn.release();
    }
}

exports.getSearchPolicy = async function(req, res) {
    console.log('policy-service getSearchPolicy : ',req.params.searchValue);
    var conn;
    var searchValue = '%' + req.params.searchValue + '%';
    console.log('policy-service getSearchPolicy : ',searchValue);
    try {
        conn = await db.getConnection();
        console.log('policy-service getSearchPolicy db getConnecton');
        var query = "SELECT * FROM webdb.tb_policy WHERE policy_name LIKE" + "'"+searchValue+"'" + ";"; 
        var rows =  await conn.query(query); // 쿼리 실행
        console.log('policy-service getSerachPolicy success');
        return rows;
    } catch(error){
        console.log('policy-service getSearchPolicy:'+error);
    } finally {
        conn.release();
    }
}

exports.getAllPolicyForSearch = async function(req, res) {
    var conn;
    try{
        conn = await db.getConnection();
        console.log('policy-service getAllPolicyForSearch db getConnection');
        var query = "SELECT * FROM webdb.tb_policy;";
        var rows = await conn.query(query); // 쿼리 실행
        // console.log(rows[0]);
        // console.log(rows[1]);
        // console.log(rows[2]); 
        return rows;
    } catch(error) {
        console.log('policy-service getAllPolicyForSearch:'+error);
    } finally {
        conn.release();
    }
}

exports.getBannerData = async function(req, res) {
    var conn;
    try{
        conn = await db.getConnection();
        console.log('policy-service getBannerData db getConnection');
        var query = "SELECT banner_name, banner_img, banner_link FROM webdb.tb_banner;";
        var rows = await conn.query(query); // 쿼리 실행
        // console.log(rows);
        return rows;
    } catch(error) {
        console.log('policy-service fetchBannerData:'+error);
    } finally {
        conn.release();
    }
};