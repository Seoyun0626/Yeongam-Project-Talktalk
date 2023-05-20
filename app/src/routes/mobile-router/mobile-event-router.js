
var express = require('express');
var router = express.Router();
var mobile_event_controller = require("../../controllers/mobile-controller/mobile-event-controller");
const verifyToken = require("../../middleware/verify_token");


  // 무화과 지급 내역 + 사용 내역
  router.get("/get-fig-history-by-user", verifyToken, async function (req, res) {
    try {
      var figUsage = await mobile_event_controller.fetchFigUsageByUser(req, res);
      var figReward = await mobile_event_controller.fetchFigRewardByUser(req, res);
      // console.log(figUsage);
      // console.log(figReward);
      res.json({
        resp:true,
        message : 'get fig history by user',
        figReward : figReward,
        figUsage : figUsage,
      })
    } catch (error) {
      console.log('mobile-event-router / error:' + error);
    }
  });

  module.exports = router;
