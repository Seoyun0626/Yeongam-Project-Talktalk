var db = require('../../utils/db');
var policy_service = require("../../services/policy-service");
var code_service = require("../../services/codeData-service");



exports.getAllPolicy = async function(req, res) {
    try{
        var result = await policy_service.getAllPolicy(req,res);
        // console.log(result);
        return result;
      } catch(error) {
        console.log('policy-controller getAllPolicy:'+error);
      }
    };





exports.getSearchPolicy = async function(req, res) {
  try{
    var result = await policy_service.getSearchPolicy(req, res);
    // console.log('mobile-policy-controller getSearchPolicy:');
    return result;
  } catch (error){
    console.log('policy-controller getSearchPolicy:'+error);
  }
}

exports.getPolicyBySelect = async function(req, res) {
  try{
    var result = await policy_service.getPolicyBySelect(req, res);
    // console.log('mobile-policy-controller getPolicyBySelect');
    return result;
  } catch (error){
    console.log('policy-controller getPolicyBySelect:'+error);
  }
}

exports.getAllPolicyForSearch = async function(req, res) {
  try{
      var result = await policy_service.getAllPolicyForSearch(req,res);
      // console.log(result);
      return result;
    } catch(error) {
      console.log('policy-controller getAllPolicyForSearch:'+error);
    }
  };

exports.getBannerData = async function(req, res) {
  try{
    var result = await policy_service.getBannerData(req, res);
    return result;
  } catch(error) {
    console.log('mobile-policy-controller fetchBannerData:'+error);
  }
};

exports.scrapOrUnscrapPolicy = async function(req, res) {
  try{
    var result = await policy_service.scrapOrUnscrapPolicy(req, res);
    return result;
  } catch(error) {
    console.log('mobile-policy-controller scrapOrUnscrapPolicy:'+error);
  }
};