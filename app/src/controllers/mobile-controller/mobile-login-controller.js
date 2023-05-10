var mobile_login_service = require("../../services/mobile-services/mobile-login-service");

// 로그인
exports.SignIn = async function(req, res) {
  try{
    // console.log('login-controller', req.body);
    const result = await mobile_login_service.SignIn(req);
    // console.log('mobile-login-controller SignIn:', result);    
    // if (result.code == 0) {
      // console.log("mobile-login-controller SiginIn 로그인 성공");
      // // 로그인 성공시 쿠키 생성
      // res.cookie('userid', result.data.userid);
      // res.cookie('username', result.data.user_name, {
      //   maxAge: 60 * 60 * 1000, // 만료 시간
      //   path: "/" // 쿠키가 전송될 경로
      // });
      // // 로그인 후 사용자 정보를 세션에 저장
      // req.session.user = result;
    // }
    // console.log('login-controller result', result);
    return result;
  } catch(error) {
    console.log('mobile-login-controller SignIn:'+error);
  }
};

// kth - mobile - renewLogin
// exports.renewLogin = async function (req, res) {
//   try {
//       const token = generateJsonWebToken(req.idPerson);
//       return res.json({
//           resp: true,
//           message: '청소년 톡talk에 오신 것을 환영합니다',
//           token: token
//       });
//   }
//   catch (err) {
//       return res.status(500).json({
//           resp: false,
//           message: err
//       });
//   }
// };



// 회원가입 컨트롤러
exports.signUp = async function(req, res) {
  try{
    var result = await mobile_login_service.signUp(req);
    return result;
  } catch(error) {
    console.log('mobile-login-controller login_check:'+error);
  }
};

exports.checkDuplicateID = async function(req, res){
  try{
    var result = await mobile_login_service.checkDuplicateID(req);
    return result;
  } catch(error) {
    console.log('mobile-login-controller checkDuplicateID:'+error);
  }
}


/*
// 회원가입 컨트롤러
exports.SignUp = async function(req, res) {
  try{
    //console.log( req.body);
    var result = await service_main.SignUp(req);
    var msg = "가입완료";
    if (result == 100) {
      msg = "이미 존재하는 ID 입니다.";
    }
    var json = {
      code: result,
      msg: msg
    };
  } catch(error) {
    console.log('login-controller SignUp:'+error);
  }
  console.log(json);
  return json;
};
*/




// 로그인 체크 컨트롤러
exports.login_check = async function(req, res) {
  try{
    //console.log( req.body);
    var result = await mobile_login_service.login_check(req);
    return result;
  } catch(error) {
    console.log('login-controller login_check:'+error);
  }
};

/*
exports.date_check = async function(req, res) {
  try{
    //console.log( req.body);
    var result = await login_service.date_check(req);
    return result;
  } catch(error) {
    console.log('login-controller date_check:'+error);
  }
};
*/


