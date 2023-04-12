var db = require('../../utils/db');
var mobile_main_service = require("../../services/mobile-services/mobile-main-service");

exports.getBannerData = async function(req, res) {
    try{
      var result = await mobile_main_service.getBannerData(req, res);
      return result;
    } catch(error) {
      console.log('mobile-policy-controller fetchBannerData:'+error);
    }
  };