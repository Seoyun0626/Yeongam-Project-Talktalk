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

exports.getPolicyName = async function(req, res) {
    try{
        var result = await code_service.getPolicyName(req, res);
        return result;
    }
    catch(error) {
        console.log('code-controller getPolicyName:'+error);
    }
};

exports.getCodeData = async function(req, res) {
    try{
      // console.log( req.body);
      var result = await code_service.getCodeData(req);
      // console.log(result.code_data_name[0]);
      return result;
    } catch(error) {
      console.log('code-controller getUserData:'+error);
    }
  };

exports.getUserCodeName = async function(req, res) {
    try{
      // console.log( req.body);
      var result = await code_service.getUserCodeName(req);
      // console.log(result.code_data_name[0]);
      return result;
    } catch(error) {
      console.log('code-controller getUserData:'+error);
    }
  };
  

exports.getCodedetail = async function(req, res) {
    try{
      //console.log( req.body);
      var result = await code_service.getCodedetail(req);
      return result;
    } catch(error) {
      console.log('code-controller getUserData:'+error);
    }
  };

exports.getCodedetail_update = async function(req, res) {
    try{
      //console.log( req.body);
      var result = await code_service.getCodedetail_update(req);
      return result;
    } catch(error) {
      console.log('code-controller getUserData:'+error);
    }
  };

exports.updateCodeDetail = async function(req, res) {
  try{
    //console.log( req.body);
    var result = await code_service.updateCodeDetail(req);
    return result;
  } catch(error) {
    console.log('code-controller getUserData:'+error);
  }
};

exports.insertCodeDetail = async function(req, res) {
  try{
    //console.log( req.body);
    var result = await code_service.insertCodeDetail(req);
    return result;
  } catch(error) {
    console.log('code-controller getUserData:'+error);
  }
};

exports.getCodeData_update = async function(req, res) {
  try{
    //console.log( req.body);
    var result = await code_service.getCodeData_update(req);
    return result;
  } catch(error) {
    console.log('code-controller getUserData:'+error);
  }
};
