var code_service = require("../../services/codeData-service");


exports.fetchData = async function(req, res) {
    try {
        var result = await code_service.fetchData(req,res);
        return result;
    } catch (error) {
        console.log('codeData-controller fetchData error:'+error);
    }
};

exports.fetchPolicyData = async function(req, res) {
    try{
        var result = await code_service.fetchPolicyData(req, res);
        return result;
    }
    catch(error) {
        console.log('code-controller fetchPolicyData:'+error);
    }
};




exports.getCodeData = async function(req, res) {
    try{
      //console.log( req.body);
      var result = await code_service.getCodeData(req);
      return result;
    } catch(error) {
      console.log('code-controller getUserData:'+error);
    }
  };