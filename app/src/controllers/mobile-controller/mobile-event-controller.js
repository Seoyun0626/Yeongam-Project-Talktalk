var mobile_event_service = require("../../services/mobile-services/mobile-event-service");



exports.fetchFigUsageByUser = async function(req, res) {
    try{
      var result = await mobile_event_service.fetchFigUsageByUser(req);
      return result;
    } catch(error) {
      console.log('mobile-event-controller fetchFigUsageByUser:'+error);
    }
  };

  exports.fetchFigRewardByUser = async function(req, res) {
    try{
      var result = await mobile_event_service.fetchFigRewardByUser(req);
      return result;
    } catch(error) {
      console.log('mobile-event-controller fetchFigRewardByUser:'+error);
    }
  };