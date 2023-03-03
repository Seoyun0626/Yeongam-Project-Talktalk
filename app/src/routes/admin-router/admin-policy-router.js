const path = require("path");
var express = require("express");
var router = express.Router();
var policy_controller = require("../../controllers/common-controller/policy-controller");
var code_controller = require("../../controllers/common-controller/codeData-controller");

var codeName = require('../../public/js/home/getCodeName');
const { json } = require("body-parser");

// const { isLoggedIn, isNotLoggedIn } = require('../lib/auth');
router.get('/show', async function (req, res) {
    try{
        var crtpage = 1;
        var totalPage = 1;
        var pageSize = 8; //한 페이지에 보여줄 정책 수
        if (req.url.split('/').length == 2){ // 처음 페이지 로딩
            var result = await policy_controller.fetchData(req, res);
            totalPage = Math.ceil(result.length/pageSize);
            result = result.slice(0, pageSize); //처음 페이지에 보여줄 정책 수만큼 가져옴
        } else { //페이지 이동
            crtpage = req.url.split('=')[1]; //현재 페이지
            var result = await policy_controller.fetchData(req, res);
            if(crtpage == undefined) crtpage = 1; //현재 페이지가 없으면 1페이지로 설정
            if(crtpage < 1) crtpage = 1; //현재 페이지가 1보다 작으면 1페이지로 설정
            if(crtpage > Math.ceil(result.length/pageSize)) crtpage = Math.ceil(result.length/pageSize); //현재 페이지가 마지막 페이지보다 크면 마지막 페이지로 설정
            var start = (crtpage-1)*pageSize;
            var end = crtpage*pageSize;
            totalPage = Math.ceil(result.length/pageSize);
            result = result.slice(start, end); //현재 페이지에 해당하는 회원 정보만 가져옴
        }
        var code_data = await code_controller.getPolicyName();
        res.render('policy/show', {
            posts:result,
            user:req.user,
            page:crtpage, //현재 페이지
            totalPage: totalPage, //총 페이지 수
            code_data:code_data,
            codeName:codeName.policy_code_to_name //정책 대상만 설정 해 놨음
        });
    } catch(error) {
        console.log('policy-router show error:'+error);
    }
  });

router.get('/upload', async function (req, res) {
    try{
        // var result = policy_controller.fetchCodeData(req,res);
        // console.log(result[0]);
        // var result = await code_controller.fetchPolicyData(req, res);
        var code_data = await code_controller.getCodeData(req, res);
        res.render('policy/upload', {
            code_data:code_data
        });
        }
    catch(error) {
        console.log('policy-router upload error:'+error);
    }
});

// 정책 업로드
router.post('/upload', async function (req, res) {
    try{
        // DB에 저장
        var result = await policy_controller.upload(req,res);
        console.log('router-upload', result);
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

router.get('/update/:id', async function(req, res){
    try{
        var result = await policy_controller.fetchpolicyByidx(req, res);
        // 접수 기간
        var start_month = result[0].application_start_date.getMonth()+1;
        if(start_month < 10) start_month = '0'+start_month;
        var start_date = result[0].application_start_date.getDate();
        if(start_date < 10) start_date = '0'+start_date;
        var start_day = result[0].application_start_date.getFullYear()+'-'+start_month+'-'+start_date;

        var end_month = result[0].application_end_date.getMonth()+1;
        if(end_month < 10) end_month = '0'+end_month;
        var end_date = result[0].application_end_date.getDate();
        if(end_date < 10) end_date = '0'+end_date;
        var end_day = result[0].application_end_date.getFullYear()+'-'+end_month+'-'+end_date;
        var code_data = await code_controller.getCodeData(req, res);
        // console.log(result[0].img);
        var content = result[0].content;
        // content를 string으로 변환
        res.render('policy/policy-update', {
            post:result[0],
            code_data:code_data,
            start_date:start_day,
            end_date:end_day,
            content:content
    });
    } catch(error) {
      console.log('policy-router update error:'+error);
    }
  });

router.post('/update/:id', async function(req, res){
    try{
        // console.log(req.params);
        var result = await policy_controller.updatePolicy(req, res);
        if(result == 0) { //성공
            res.redirect('/admin/policy/show');
        } else { //실패
            res.redirect('/admin/policy/update/'+req.params.id);
        }
    } catch(error) {
        console.log('policy-router update error:'+error);
    }
});

router.get('/delete/:id', async function(req, res){
    try{
        var result = await policy_controller.deletePolicy(req, res);
        if(result == 0) { //성공
            res.redirect('/admin/policy/show');
        } else { //실패
            res.redirect('/admin/policy/show');
        }
    } catch(error) {
        console.log('policy-router delete error:'+error);
    }
});


router.get('/banner', async function (req, res) {
    try{
        var result = await policy_controller.fetchBannerData(req,res);
        res.render('policy/banner', {banner:result});
        }
    catch(error) {
        console.log('policy-router banner error:'+error);
    }
});



router.post('/banner', async function (req, res) {
    try{
        // DB에 저장
        var result = await policy_controller.banner(req,res);
        if(result == 0) { //성공
            res.redirect('/admin/policy/banner');
        } else { //실패
            res.redirect('/admin/policy/banner');
        }
    }
    catch(error) {
        console.log('policy-router banner error:'+error);
    }
});

router.get('/banner/delete/:id', async function(req, res){
    try{
        var result = await policy_controller.deleteBanner(req, res);
        res.redirect('/admin/policy/banner');
        }
    catch(error) {
        console.log('policy-router banner delete error:'+error);
    }
});


module.exports = router;