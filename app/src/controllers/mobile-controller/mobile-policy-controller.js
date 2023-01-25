var db = require('../../utils/db');
var policy_service = require("../../services/policy-service");



exports.getAllPolicy = async function(req, res) {
    try{
        var result = await policy_service.getAllPolicy(req,res);
        console.log(result);
        return result;
      } catch(error) {
        console.log('policy-controller getAllPolicy:'+error);
      }
    };