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
 

  module.exports = router;