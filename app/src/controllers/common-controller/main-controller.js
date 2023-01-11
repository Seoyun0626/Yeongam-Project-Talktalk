var main_service = require("../../services/main-service");
/*
exports.GetJsonList = async function(req, res) {
  var result = await service_main.GetJsonList();
  var json = {
    title: "view",
    data: result
  };
  res.send(json);
};
*/

// 게시판
exports.dashboard = async function(req, res) {
  try{
    //console.log( req.body);
    var result = await main_service.dashboard(req);
    return result;
  } catch(error) {
    console.log('main_controller dashboard:'+error);
  }
};

exports.getFile = async function(req, res) {
  try{
    //console.log( req.body);
    var result = await main_service.getFile(req);
    return result;
  } catch(error) {
    console.log('main_controller getFile:'+error);
  }
};

exports.getProject = async function(req, res) {
  try{
    //console.log( req.body);
    var result = await main_service.getProject(req);
    return result;
  } catch(error) {
    console.log('main_controller getProject:'+error);
  }
};

exports.getSubproject = async function(req, res) {
  try{
    //console.log( req.body);
    var result = await main_service.getSubproject(req);
    return result;
  } catch(error) {
    console.log('main_controller getSubproject:'+error);
  }
};

exports.getPowersave = async function(req, res) {
  try{
    //console.log( req.body);
    var result = await main_service.getPowersave(req);
    return result;
  } catch(error) {
    console.log('main_controller getPowersave:'+error);
  }
};

exports.getSensorName = async function(req, res) {
  try{
    //console.log( req.body);
    var result = await main_service.getSensorName(req);
    return result;
  } catch(error) {
    console.log('main_controller getSensorName:'+error);
  }
};

exports.sensorData = async function(req, res) {
  try{
    var result = await main_service.sensorData(req);
    return result;
  } catch(error) {
    console.log('main_controller sensorData:'+error);
  }
};

exports.prjectData = async function(req, res) {
  try{
    var result = await main_service.prjectData(req);
    return result;
  } catch(error) {
    console.log('main_controller prjectData:'+error);
  }
};

exports.getControlCommand = async function(req, res) {
  try{
    var result = await main_service.getControlCommand(req);
    return result;
  } catch(error) {
    console.log('main_controller getControlCommand:'+error);
  }
};
