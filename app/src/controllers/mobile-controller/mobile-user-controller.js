var mobile_user_service = require("../../services/mobile-services/mobile-user-service");

exports.getUserById = async function(req, res) {
    try{
      var result = await mobile_user_service.getUserById(req);
      return result;
    } catch(error) {
      console.log('login-controller get user by id:'+error);
    }
  }