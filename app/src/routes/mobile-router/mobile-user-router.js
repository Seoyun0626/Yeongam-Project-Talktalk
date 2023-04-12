const path = require("path");
var express = require("express");
var router = express.Router();
var mobile_user_controller = require("../../controllers/mobile-controller/mobile-user-controller");

router.get("/get-User-By-Id", async function(req, res){
    try{
    var result = await mobile_user_controller.getUserById(req, res);
    console.log(result[0][1]);
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

  module.exports = router;