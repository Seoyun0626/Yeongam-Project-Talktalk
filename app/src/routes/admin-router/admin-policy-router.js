const path = require("path");
var express = require("express");
var router = express.Router();
var policy_controller = require("../../controllers/common-controller/policy-controller");

const passport = require('passport');

// const { isLoggedIn, isNotLoggedIn } = require('../lib/auth');
router.get('/show', async function (req, res) {
    try{
        var result = await policy_controller.fetchData(req,res);
        res.render('policy/show', {
            posts:result,
            user:req.user
        });
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

router.post('/upload', async function (req, res) {
    try{
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



router.post('/banner', async function (req, res) {
    try{
        // console.log(req.body);
        // DB에 저장
        var result = await policy_controller.banner(req,res);
        if(result == 0) { //성공
            res.redirect('/admin/policy/show');
        } else { //실패
            res.redirect('/admin/policy/banner');
        }
    }
    catch(error) {
        console.log('policy-router banner error:'+error);
    }
});



module.exports = router;