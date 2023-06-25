const path = require("path");
var express = require("express");
var json2xls = require('json2xls');
var fs = require('fs');
var XLSX = require('xlsx');
var router = express.Router();
//var checkAuth = require('../utils/checkauth');
var dataif_controller = require("../../controllers/common-controller/dataif-controller");
var code_controller = require("../../controllers/common-controller/codeData-controller");

const ensureAuth = require("../../utils/middleware/ensureAuth");
const asyncHandler = require("../../utils/middleware/asyncHandler");

var codeName = require('../../public/js/home/getCodeName');

const passport = require('passport');

//로그인 시 출력하는 화면
router.get('/', ensureAuth, asyncHandler(async function (req, res) {
  var urltype = req.url.split('/')[1].split('=')[0];
  var crtpage = 1;
  var totalPage = 1;
  var pageSize = 6; //한 페이지에 보여줄 회원 정보 수
  if (urltype == '?search') { //검색어 입력
    var result = await dataif_controller.fetchDataByUserid(req, res);
  } else if (urltype == '?page') { //페이지 이동
    crtpage = req.url.split('=')[1]; //현재 페이지
    var result = await dataif_controller.fetchData(req, res);
    if (crtpage == undefined) crtpage = 1; //현재 페이지가 없으면 1페이지로 설정
    if (crtpage < 1) crtpage = 1; //현재 페이지가 1보다 작으면 1페이지로 설정
    if (crtpage > Math.ceil(result.length / pageSize)) crtpage = Math.ceil(result.length / pageSize); //현재 페이지가 마지막 페이지보다 크면 마지막 페이지로 설정
    var start = (crtpage - 1) * pageSize;
    var end = crtpage * pageSize;
    totalPage = Math.ceil(result.length / pageSize);
    result = result.slice(start, end); //현재 페이지에 해당하는 회원 정보만 가져옴
  } else { //일반 접속
    var result = await dataif_controller.fetchData(req, res);
    totalPage = Math.ceil(result.length / pageSize);
    result = result.slice(0, pageSize);
  }
  var code_data = await code_controller.getUserCodeName();
  // console.log(req.session);
  res.render('dataif/mem',
    {
      posts: result,
      code_data: code_data,
      page: crtpage, //현재 페이지
      totalPage: totalPage, //총 페이지 수
      codeName: codeName.user_code_to_name,
      emd_code_to_name: codeName.emd_code_to_name,
      user_type_to_name: codeName.user_type_to_name,
      role_code_to_class: codeName.role_code_to_class, //권한
    });
}, 'dataif-router / error:'));


// 무화과 사용 로그 확인 페이지
router.get('/figManage/:id', ensureAuth, asyncHandler(async function (req, res) {
  var id = req.params.id; //회원 아이디
  var figUsage = await dataif_controller.fetchFigUsageByUid(req, res); //무화과 사용 로그
  var eventPart = await dataif_controller.fetchEventPartByUid(req, res); //행사 참여 로그
  res.render('dataif/figManage',
    {
      figUsage: figUsage,
      eventPart: eventPart,
      userid: id
    });
}, 'dataif-router / error:'));


router.post('/', asyncHandler(async function (req, res) {
  var result = await dataif_controller.fetchData(req, res);
  res.render('dataif/index', { posts: result });
}, 'dataif-router / error:'));


// 약관 설정 페이지
router.get('/terms', ensureAuth, asyncHandler(async function (req, res) {
    var result = await dataif_controller.fetchTermData(req, res);
    res.render('dataif/terms', { posts: result });
}, 'dataif-router / error:'));
router.post('/terms', asyncHandler(async function (req, res) {
    var result = await dataif_controller.updateTermData(req, res);
    res.redirect('/admin/dataif/terms');
}, 'dataif-router / error:'));


// 회원 정보 수정 페이지
router.get('/update/:id', ensureAuth, asyncHandler(async function (req, res) {
    //데이터 받아오기
    var result = await dataif_controller.fetchDataUserUpdate(req, res);
    var code_data = await code_controller.getCodeData(req, res);
    res.render('dataif/update', {
      post: result[0],
      code_data: code_data
    });
}, 'dataif-router / error:'));
router.post('/update/:id', asyncHandler(async function (req, res) {
    var result = await dataif_controller.update(req, res);
    if (result == 0) {res.redirect("/admin/dataif");} //비밀번호가 맞는 경우
    else { //비밀번호가 틀린 경우
      res.redirect("/admin/dataif/update/" + req.params.id);
    }
}, 'dataif-router / error:'));


// 회원 정보 삭제
router.get('/delete/:id', ensureAuth, asyncHandler(async function (req, res) {
    var result = await dataif_controller.deleteUser(req, res);
    res.redirect("/admin/dataif");
}, 'dataif-router delete/ error:'));

// 엑셀 다운로드
router.get('/excel', ensureAuth, asyncHandler(async function (req, res) {
    var result = await dataif_controller.fetchData(req, res); //회원 정보 가져오기
    var xls = json2xls(result); //json 데이터를 엑셀 파일로 변환
    fs.writeFileSync('user_data.xlsx', xls, 'binary'); //엑셀 파일 저장
    res.download('user_data.xlsx'); //엑셀 파일 다운로드
}, 'dataif-router excel/ error:'));

//테스트, 사용안하는 코드

// 비밀번호 초기화
router.get('/resetPW/:id', asyncHandler(async function (req, res) {
  var result = await dataif_controller.resetPW(req, res);
  res.redirect('/admin/dataif');
}, 'dataif-router resetPW error:'));


// router.get('/excelup', async function (req, res) {
//   try {
//     if (req.session.user == undefined) {
//       res.redirect('/admin/auth/login');
//       return;
//     }
//     // 엑셀 파일 읽기
//     var workbook = XLSX.readFile('user_data.xlsx');
//     var sheet_name_list = workbook.SheetNames;
//     var xlData = XLSX.utils.sheet_to_json(workbook.Sheets[sheet_name_list[0]]);
//     // 엑셀 파일 데이터 DB에 저장
//     var result = await dataif_controller.excelData(req, res, xlData);
//     res.redirect('/admin/dataif');
//   } catch (error) {
//     console.log('dataif-router / error:' + error);
//   }
// });


// router.get('/datapermit', async function (req, res) {
//   try {
//     var result = await dataif_controller.fetchData(req, res);
//     res.render('dataif/datapermit', { posts: result });
//   } catch (error) {
//     console.log('dataif-router /datapermit error:' + error);
//   }
// });

module.exports = router;