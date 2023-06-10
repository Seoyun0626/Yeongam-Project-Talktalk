
var express = require('express');
var router = express.Router();
var mobile_event_controller = require("../../controllers/mobile-controller/mobile-event-controller");
const verifyToken = require("../../middleware/verify_token");

// 무화과 지급
router.post("/give-fig/:eid", verifyToken, async function(req, res){
  try {
    // console.log('mobile give fig');
    var result = await mobile_event_controller.giveFig(req, res);
    // console.log('mobile-event-router give-fig', result);
    res.json({
      resp : true,
      message : 'give fig'
    })

  } catch(error){
    console.log('mobile-event-router give-fig error:' + error);

  }
});

// router.post("/use-fig/:eid")

router.get("/get-attendance", verifyToken, async function(req, res){
  try {
    console.log('mobile get-attendance');
    var result = await mobile_event_controller.getAttendance(req, res);
    // result = result.slice(0, result.length - 1);
    // console.log('mobile-event-router get-attendance', result);
    res.json({
      resp : true,
      message : 'get-attendance',
      attendaceLog : result
    })

  } catch(error){
    console.log('mobile-event-router get-attendance error:' + error);

  }

});



// 무화과 지급 내역 + 사용 내역 불러오기
router.get("/get-fig-history-by-user", verifyToken, async function (req, res) {
  try {
    var figUsage = await mobile_event_controller.fetchFigUsageByUser(req, res);
    var figReward = await mobile_event_controller.fetchFigRewardByUser(req, res);
    // console.log(figUsage);
    // console.log(figReward);
    res.json({
      resp:true,
      message : 'get fig history by user',
      figReward : figReward, // 무화과 지급 내역
      figUsage : figUsage, // 무화과 사용 내역

    })
  } catch (error) {
    console.log('mobile-event-router / error:' + error);
  }
});

module.exports = router;
