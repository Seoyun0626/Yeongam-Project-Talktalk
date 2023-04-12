const path = require("path");
var express = require("express");
var router = express.Router();
var mobile_policy_controller = require("../../controllers/mobile-controller/mobile-policy-controller");


router.get('/get-all-policy', async function(req, res){
    try{
      var result = await mobile_policy_controller.getAllPolicy(req,res);
      // console.log('mobile-router get-all-policy result : ', result);
      // res.render('policy/get-all-policy', {
      //     posts:result,
      //     user:req.user
      // }
      // );
      res.json({
        resp:true,
        message : 'get all policies',
        policies : result,
      })
  } catch(error) {
      console.log('policy-router get-all-policy error:'+error);
      res.json({
        resp:false,
        message : 'Failure get all policies'
      })
  }
  });
  
  
  
  
  
  // 정책 텍스트-제목 검색
  router.get('/get-search-policy/:searchValue', async function(req, res) {
    console.log('mobile-router', req.params.searchValue );
    try{
      var result = await mobile_policy_controller.getSearchPolicy(req,res);
      // console.log('mobile-router get-search-policy result : ', result);
  
      res.json({
        resp:true,
        message : 'get search policies',
        policies : result
      })
  } catch(error) {
      console.log('policy-router get-search-policy error:'+error);
      res.json({
        resp:false,
        message : 'Failure get search policies'
      })
  }
  })
  
  // 검색 조건 선택 결과
  router.get('/get-select-policy/:code', async function(req, res){
    // console.log('mobile-router get-select-policy', req.params.code);
    try{
      var result = await mobile_policy_controller.getPolicyBySelect(req,res);
      // console.log('mobile-router get-all-policy result : ', result);
      // res.render('policy/get-all-policy', {
      //     posts:result,
      //     user:req.user
      // }
      // );
      res.json({
        resp:true,
        message : 'get all policies',
        policies : result,
      })
  } catch(error) {
      console.log('policy-router get-all-policy error:'+error);
      res.json({
        resp:false,
        message : 'Failure get all policies'
      })
  }
    
  
  })

  // 필요없음
router.get('/get-all-policy-for-search', async function(req, res) {
    try{
      var result = await mobile_policy_controller.getAllPolicyForSearch(req,res);
      // console.log('mobile-router get-all-posts-for-search result : ', result);
  
      res.json({
        resp:true,
        message : 'get-all-posts-for-search policies',
        policies : result
      })
  } catch(error) {
      console.log('policy-router get-search-policy error:'+error);
      res.json({
        resp:false,
        message : 'Failure get-search-policy policies'
      })
  }
  });

  module.exports = router;