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
exports.retrieveData = async function(req, res) {
  try{
    //console.log( req.body);
    var result = await dataif_service.retrieveData(req);
    return result;
  } catch(error) {
    console.log('dataif-controller retrieveData:'+error);
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



exports.create = async function(req, res) {
  try{
    /*
    var rsltcls, rsltcnt;
    rsltcls = await dataif_service.getClass(req, res);
    var senId=[],s_senId=[];
    for(idx in rsltcls)
      if(rsltcls[idx].sen_grp=='0001') { if(rsltcls[idx].prj_grp=='0001') s_senId.push(rsltcls[idx].sen_id); }
      else senId.push(rsltcls[idx].sen_id);
    req.body.s_senId=s_senId;
    req.body.senId=senId;
    var aJsonArray = new Array();
    if(s_senId.length>0) {
      rsltcnt=await dataif_service.s_getCount(req, res);
      aJsonArray.push(rsltcnt);
    }
    if(senId.length>0) {
      rsltcnt=await dataif_service.getCount(req, res);
      aJsonArray.push(rsltcnt);
    }
    for(idx in aJsonArray) {
      //if(aJsonArray[idx][0].senid=='undefined') {
      //  for(var iidx=0;iidx<aJsonArray[idx].length;iidx++) {
      //    if(aJsonArray[idx][iidx].senid!='undefined') console.log(aJsonArray[idx][iidx].senid);
      //  }
      //} else {
        if(aJsonArray[idx][0]!=undefined) { if(aJsonArray[idx][0].senid!=undefined) console.log(aJsonArray[idx][0].senid); }
      //}
    }*/

    //rslt = await dataif_service.setCount(req, res);
    var result = await dataif_service.create(req);
    return result;
  } catch(error) {
    console.log('dataif-controller create:'+error);
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

exports.retrieveDataProject = async function(req, res) {
  try{
    //console.log( req.body);
    var result = await dataif_service.retrieveDataProject(req);
    return result;
  } catch(error) {
    console.log('dataif-controller retrieveDataProject:'+error);
  }
};

exports.fetchDataSensor = async function(req, res) {
  try{
    var result = await dataif_service.fetchDataSensor(req);
    return result;
  } catch(error) {
    console.log('dataif-controller fetchDataSensor:'+error);
  }
};

exports.permit = async function(req, res) {
  try{
    var result = await dataif_service.permit(req);
    return result;
  } catch(error) {
    console.log('dataif-controller permit:'+error);
  }
};
/*
exports.s_getCount = async function(req, res) {
  try{
    var result = await dataif_service.s_getCount(req);
    return result;
  } catch(error) {
    console.log('dataif-controller s_getCount:'+error);
  }
};

exports.getCount = async function(req, res) {
  try{
    var result = await dataif_service.getCount(req);
    return result;
  } catch(error) {
    console.log('dataif-controller getCount:'+error);
  }
};

exports.setCount = async function(req, res) {
  try{
    var result = await dataif_service.setCount(req);
    return result;
  } catch(error) {
    console.log('dataif-controller setCount:'+error);
  }
};
*/