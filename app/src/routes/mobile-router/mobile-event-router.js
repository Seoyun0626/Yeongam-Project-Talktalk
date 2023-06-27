
var express = require('express');
var router = express.Router();
var mobile_event_controller = require("../../controllers/mobile-controller/mobile-event-controller");
const verifyToken = require("../../middleware/verify_token");


// 무화과 지급 - 출석체크
// giveFigForAttendance
router.post("/give-fig-for-attendance", verifyToken, async function(req, res){
  try {
    // console.log('mobile give fig');
    var result = await mobile_event_controller.giveFigForAttendance(req, res);
    // console.log('mobile-event-router give-fig', result);
    res.json({
      resp : true,
      message : 'give fig for attendance'
    })

  } catch(error){
    console.log('mobile-event-router give-fig error:' + error);

  }
});

// 무화과 지급 - 친구초대
// giveFigForInvitation
router.post("/give-fig-for-invitation", verifyToken, async function(req, res) {
  try {
    var result = await mobile_event_controller.giveFigForInvitation(req, res);
    console.log(result);
    if (result === 'success') {
      res.json({
        resp: true,
        message: 'give fig for invitation'
      });
    } else if (result === 'invalidCode') {
      res.json({
        resp: false,
        message: '유효하지 않은 코드입니다.'
      });
    } else {
      res.json({
        resp: false,
        message: 'Failure give fig for invitation'
      });
    }
  } catch(error) {
    console.log('mobile-event-router give-fig error:' + error);
    res.json({
      resp: false,
      message: 'Failure give fig for invitation'
    });
  }
});


// 무화과 지급 - 주간 무화과 챌린지
// giveFigForWeeklyChanllenge

// 출석 체크 내역 가져오기
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
    console.log('mobile-event-router get-fig-history-by-user error:' + error);
  }
});




module.exports = router;
