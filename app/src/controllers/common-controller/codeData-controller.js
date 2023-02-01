var main_service = require("../../services/codeData-service");

exports.fetchData = async function(req, res) {
    try {
        var result = await main_service.fetchData(req,res);
        return result;
    } catch (error) {
        console.log('codeData-controller fetchData error:'+error);
    }
};