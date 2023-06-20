var dataif_service = require("../../services/dataif-service");

// 로그인 체크 컨트롤러
exports.fetchData = async function(req, res) {
  try{
    //req.user.userid = 'admin'; //임시
    var result = await dataif_service.fetchData(req);
    return result;
  } catch(error) {
    console.log('dataif-controller fetchData:'+error);
  }
};


exports.fetchFigUsageByUid = async function(req, res) {
  try{
    var result = await dataif_service.fetchFigUsageByUid(req);
    return result;
  } catch(error) {
    console.log('dataif-controller fetchFigDataByUid:'+error);
  }
};
exports.fetchEventPartByUid = async function(req, res) {
  try{
    var result = await dataif_service.fetchEventPartByUid(req);
    return result;
  } catch(error) {
    console.log('dataif-controller fetchEventPartByUid:'+error);
  }
};

exports.resetPW = async function(req, res) {
  try{
    var result = await dataif_service.resetPW(req);
    return result;
  } catch(error) {
    console.log('dataif-controller resetPW:'+error);
  }
};

// userid로 사용자 정보 가져오기
exports.fetchDataByUserid = async function(req, res) {
  try{
    var result = await dataif_service.fetchDataByUserid(req);
    // console.log(result);
    return result;
  } catch(error) {
    console.log('dataif-controller fetchDataByUserid:'+error);
  }
};

// 회원 가입 약관 가져오기
exports.fetchTermData = async function(req, res) {
  try{
    var result = await dataif_service.fetchTermData(req);
    return result;
  } catch(error) {
    console.log('dataif-controller fetchTermData:'+error);
  }
};

exports.updateTermData = async function(req, res) {
  try{
    var result = await dataif_service.updateTermData(req);
    return result;
  } catch(error) {
    console.log('dataif-controller updateTermData:'+error);
  }
};

exports.fetchDataUserUpdate = async function(req, res) {
  try{
    var result = await dataif_service.fetchDataUserUpdate(req);
    return result;
  } catch(error) {
    console.log('dataif-controller fetchDataUserUpdate:'+error);
  }
};

exports.update = async function(req, res) {
  try{
    var result = await dataif_service.update(req);
    return result;
  } catch(error) {
    console.log('dataif-controller update:'+error);
  }
};

exports.deleteUser = async function(req, res) {
  try{
    var result = await dataif_service.deleteUser(req);
    return result;
  } catch(error) {
    console.log('dataif-controller deleteUser:'+error);
  }
};

exports.giveFig = async function(req, res) {
  try{
    var result = await dataif_service.giveFig(req);
    return result;
  } catch(error) {
    console.log('dataif-controller giveFig:'+error);
  }
};


exports.excelData = async function(req, res, xlData) {
  try{
    var result = await dataif_service.excelData(req, res, xlData);
    return result;
  } catch(error) {
    console.log('dataif-controller excelData:'+error);
  }
};
