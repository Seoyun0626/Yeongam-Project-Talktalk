const path = require("path");
var express = require("express");
var router = express.Router();
var mobile_main_controller = require("../../controllers/mobile-controller/mobile-main-controller");




// 배너 이미지, 링크
router.get('/banner', async function (req, res) {
    try{
        var result = await mobile_main_controller.getBannerData(req,res);
        // res.render('policy/banner', {banner:result});
        res.json({
          resp:true,
          message : 'get banner data',
          banners : result
        })
        }
    catch(error) {
        console.log('mobile-router banner error:'+error);
        res.json({
          resp:false,
          message : 'Failure get-policy-banner policies'
        })
    }
  });

  module.exports = router;
