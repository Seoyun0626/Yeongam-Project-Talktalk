var code_service = require("../../services/codeData-service");


exports.fetchData = async function(req, res) {
    try {
        var result = await code_service.fetchData(req,res);
        return result;
    } catch (error) {
        console.log('codeData-controller fetchData error:'+error);
    }
};

exports.getEmdClassCode = async function(req, res) {
    try {
        var result = await code_service.getEmdClassCode(req,res);
        return result;
    } catch (error) {
        console.log('codeData-controller getEmdClassCode error:'+error);
    }
};


exports.getUserType = async function(req, res) {
    try{
      var result = await code_service.getUserType(req);
      return result;
    } catch(error) {
      console.log('code-controller getUserType:'+error);
    }
  };
  
exports.getParentsAgeCode = async function(req, res) {
try{
    var result = await code_service.getParentsAgeCode(req);
    return result;
} catch(error) {
    console.log('code-controller getParentsAgeCode:'+error);
}
};

exports.getYouthAgeCode = async function(req, res) {
try{
    var result = await code_service.getYouthAgeCode(req);
    return result;
} catch(error) {
    console.log('code-controller getYouthAgeCode:'+error);
}
};

exports.getPolicyField = async function(req, res) {
    try{
        var result = await code_service.getPolicyField(req);
        return result;
        }
    catch(error) {
        console.log('code-controller getPolicyField:'+error);
    }
};

exports.getPolicyCharacter = async function(req, res) {
    try{
        var result = await code_service.getPolicyCharacter(req);
        return result;
    }
    catch(error) {
        console.log('code-controller getPolicyCharacter:'+error);
    }
};

exports.getPolicyInstitution = async function(req, res) {
    try{
        var result = await code_service.getPolicyInstitution(req);
        return result;
    }
    catch(error) {
        console.log('code-controller getPolicyInstitution:'+error);
    }
};

exports.getTarget = async function(req, res) {
    try{
        var result = await code_service.getTarget(req);
        return result;
    }
    catch(error) {
        console.log('code-controller getTarget:'+error);
    }
};