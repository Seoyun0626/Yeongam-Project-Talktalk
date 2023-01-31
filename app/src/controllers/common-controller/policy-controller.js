var policy_service = require("../../services/policy-service");

// 회원가입 컨트롤러
// exports.signUp = async function(req, res) {
//     try{
//       var result = await policy_service.signUp(req);
//       return result;
//     } catch(error) {
//       console.log('login-controller login_check:'+error);
//     }
//   };

exports.upload = async function(req, res) {
    try{
      var result = await policy_service.upload(req);
      return result;
    } catch(error) {
      console.log('policy-controller login_check:'+error);
    }
  };
  
exports.banner = async function(req, res) {
    try{
      var result = await policy_service.banner(req);
      return result;
    } catch(error) {
      console.log('policy-controller login_check:'+error);
    }
  };

exports.fetchData = async function(req, res) {
    try{
      var result = await policy_service.fetchData(req);
      return result;
    } catch(error) {
      console.log('policy-controller login_check:'+error);
    }
  };

exports.fetchCodeData = async function(req, res) {
    try{
      var result = await policy_service.fetchCodeData(req);
      return result;
    } catch(error) {
      console.log('policy-controller login_check:'+error);
    }
  };