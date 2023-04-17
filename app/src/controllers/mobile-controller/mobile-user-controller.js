var mobile_user_service = require("../../services/mobile-services/mobile-user-service");


exports.getTestData = async function(req, res){
  try{
    var result = await mobile_user_service.getTestData(req);
    return result;
  } catch(error) {
    console.log('login-controller get test data:'+error);
  }
}


exports.getUserById = async function(req, res) {
    try{
      var result = await mobile_user_service.getUserById(req, res);
      return result;
    } catch(error) {
      console.log('mobile-user-controller get user by id:'+error);
    }
  }