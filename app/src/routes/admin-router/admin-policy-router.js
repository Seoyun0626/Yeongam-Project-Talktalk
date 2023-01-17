const path = require("path");
var express = require("express");
var router = express.Router();
var multer = require('multer');
var policy_controller = require("../../controllers/common-controller/policy-controller");

const passport = require('passport');

// const { isLoggedIn, isNotLoggedIn } = require('../lib/auth');
router.get('/show', function (req, res) {
    try{
      res.render('policy/show');
    } catch(error) {
        console.log('policy-router show error:'+error);
    }
  });

router.get('/upload', function (req, res) {
    try{
        res.render('policy/upload');
        }
    catch(error) {
        console.log('policy-router upload error:'+error);
    }
});

let storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, 'src/public/upload/policy');
    },
    filename: function (req, file, cb) {
        // cb(null, file.originalname);
        cb(null, Date.now() + path.extname(file.originalname));
    }
});

router.post('/upload', async function (req, res) {
    try{
        // console.log(req.body);
        // 이미지 업로드
        var upload = multer({ 
            storage: storage,
            rename: function (fieldname, filename) {
                return filename;
            }
        }).single('imgFile');
        var upload = multer({ storage: storage }).single('imgFile');
        upload(req, res, function (err) {
            if (err instanceof multer.MulterError) {
                console.log('multer error:'+err);
            } else if (err) {
                console.log('multer error:'+err);
            }
        });
        // DB에 저장
        var result = await policy_controller.upload(req,res);
        if(result == 0) { //성공
            res.redirect('/admin/policy/show');
        } else { //실패
            res.redirect('/admin/policy/upload');
        }
    }
    catch(error) {
        console.log('policy-router upload error:'+error);
    }
});

router.get('/banner', function (req, res) {
    try{
        res.render('policy/banner');
        }
    catch(error) {
        console.log('policy-router banner error:'+error);
    }
});




module.exports = router;