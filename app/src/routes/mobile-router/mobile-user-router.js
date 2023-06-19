const path = require("path");
var express = require("express");
var router = express.Router();
var mobile_user_controller = require("../../controllers/mobile-controller/mobile-user-controller");
const verifyToken = require("../../middleware/verify_token");



router.get("/get-user-by-id", verifyToken, async function(req, res){
    try{
    console.log('mobile-router get user by id');
    var result = await mobile_user_controller.getUserById(req, res);
    // console.log(result);

    res.json({
      resp:true,
      message : 'get user by id',
      user :  result
    })
    
  } catch(error) {
    console.log('mobile-router get-user-by-id:'+error);
    res.json({
      resp:false,
      message : 'Failure get user by id',
    
    })
  }
    
  });

  router.put("/change-email", verifyToken, async function(req, res){
    try{
      console.log('mobile-router change email');
      var result = await mobile_user_controller.changeEmail(req, res);
      // console.log(result);
  
      if(result == 0){
        res.json({
          resp:true,
          message : 'change email',
        })
      }
      
    } catch(error) {
      console.log('mobile-router change-email:'+error);
      res.json({
        resp:false,
        message : 'Failure change emal',
      
      })
    }

  });


  router.put("/change-extra-info", verifyToken, async function(req, res){
    try{
      console.log('mobile-router  change-extra-info');
      var result = await mobile_user_controller.changeExtraInfo(req, res);
      // console.log(result);
  
      if(result == 0){
        res.json({
          resp:true,
          message : 'change-extra-info',
        })
      }
      
    } catch(error) {
      console.log('mobile-router change-extra-info:'+error);
      res.json({
        resp:false,
        message : 'Failure change-extra-info',
      
      })
    }

  });

  router.get("/get-fig-count", verifyToken, async function (req, res) {
    try {
      var figCount = await mobile_user_controller.getFigCount(req, res);
      figCount = figCount[0]["fig"]
      // console.log(figCount);
      res.json({
        resp:true,
        message : 'get fig count',
        figCount : figCount, // 무화과 개수
      })
    } catch (error) {
      console.log('mobile-user-router get fig count error:' + error);
    }
  });

 
 

  module.exports = router;