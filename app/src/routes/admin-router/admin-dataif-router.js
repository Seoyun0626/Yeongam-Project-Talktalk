const path = require("path");
var express = require("express");
var router = express.Router();
//var checkAuth = require('../utils/checkauth');
var dataif_controller = require("../../controllers/common-controller/dataif-controller");

//js함수
var memFunc = require('../../public/js/home/memFunc'); //mem의 ejs에서 활용하는 함수들
const passport = require('passport');
/*
var Post = require('../../models/Post');

var multer = require('multer');  //multer 모듈 import
var uploadImg = multer({dest: 'public/upload/img/'}); //업로드 경로 설정
var uploadFile = multer({dest: 'public/upload/file/'}); //업로드 경로 설정
//multer({ dest: 'uploads/', limits: { fileSize: 5 * 1024 * 1024 } });
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'public/uploads/')
  },
  filename: function (req, file, cb) {
    cb(null, new Date().valueOf() + path.extname(file.originalname))
  }
})

const fileFilter = function (req, file, cb) {
  let typeArray = file.mimetype.split('/');
  let fileType = typeArray[1];
  if (fileType == 'jpg' || fileType == 'png' || fileType == 'jpeg' || fileType == 'gif') {
      cb(null, true);
  } else {
      req.fileValidationError = "jpg,jpeg,png,gif 파일만 업로드 가능합니다.";
      cb(null, false)
  }
}

const upload = multer({
  storage: storage,
  fileFilter: fileFilter,
  limits: {
      fileSize: 5 * 1024 * 1024
  }
});
*/

/*
router.post("/dataif", checkAuth, async function(req, res) {
    console.log('dataif:'+req.user)
    try{
        // 로그인 확인을 위해 컨트롤러 호출
        var result = await main_controller.dataif(req, res);

        res.render('dataif', {'id':req.user});
    } catch(error) {
        console.log('main-router dataif error:'+error);
    }
});
*/
//로그인 시 출력하는 화면
router.get('/', async function(req, res){
  try{
    var result = await dataif_controller.fetchData(req, res);
/*
    var rtnparams=[];
    rtnparams.totalPages=result.totalPages;
    rtnparams.page=result.page;
    rtnparams.srchword=req.query.srchword;
    delete result.totalPages;
    delete result.page;
*/
    res.render('dataif/mem', 
    {
      posts:result,
      emd_code_to_name:memFunc.emd_code_to_name, //읍면동코드
      age_code_to_class:memFunc.age_code_to_class, //연령대
      role_code_to_class:memFunc.role_code_to_class, //권한
    });//, rtnparams:rtnparams
  } catch(error) {
    console.log('dataif-router / error:'+error);
  }
});

router.post('/', async function(req, res){
  try{
    console.log("req.user");
    var result = await dataif_controller.fetchData(req, res);
    res.render('dataif/index', {posts:result});
  } catch(error) {
    console.log('dataif-router / error:'+error);
  }
});


// create
router.put('/', async function(req, res){
  try{
    var result = await dataif_controller.create(req, res);
    res.redirect('/dataif');
  } catch(error) {
    console.log('dataif-router create error:'+error);
  }
});

// terms
router.get('/terms', async function(req, res){
  try{
    res.render('dataif/terms');
  }
  catch(error) {
    console.log('dataif-router /terms error:'+error);
  }
});

// update : 회원 정보 수정
// router.put('/:id', async function(req, res){
router.get('/update/:id', async function(req, res){
  try{
    // res.redirect("/dataif/update/"+req.user.id);
    // console.log("update:"+req.params.id);
    //데이터 받아오기
    var result = await dataif_controller.fetchDataByUserid(req, res);
    res.render('dataif/update', {post:result});
  } catch(error) {
    console.log('dataif-router update error:'+error);
  }
});

router.post('/update/:id', async function(req, res){
  try{
    var result = await dataif_controller.update(req, res);
    res.redirect("/admin/dataif");
  } catch(error) {
    console.log('dataif-router update error:'+error);
  }
});

router.put('/:id', async function(req, res){
  try{
    var result = await dataif_controller.update(req, res);
    //console.log(result)
    //if(result) res.render('dataif/edit', {post:result});
    //else res.render('dataif/edit', {post:result});
    
    res.redirect("/dataif");
  } catch(error) {
    console.log('dataif-router update error:'+error);
  }
});

// New
router.get('/new', function(req, res){
  console.log('dataif-router new');
  res.render('dataif/new', {parent_board_id:req.params.id});
});

router.get('/:id/new', function(req, res){
  res.render('dataif/new', {parent_board_id:req.params.id});
});


// show
router.get('/:id', async function(req, res){
  try{
    var result = await dataif_controller.retrieveData(req, res);
    res.render('dataif/show', {post:result});
  } catch(error) {
    console.log('dataif-router show error:'+error);
  }
});

// edit
router.get('/:id/edit', async function(req, res){
  try{
    var result = await dataif_controller.retrieveData(req, res);
    
    res.render('dataif/edit', {post:result});
  } catch(error) {
    console.log('dataif-router edit error:'+error);
  }
});



// destroy
router.delete('/:id', async function(req, res){
  try{
    var result = await dataif_controller.delete(req, res);

    if(result) res.json({success: true, msg:'삭제하였습니다.'});
    else res.json({success: false, msg:'삭제실패하였습니다.'});

  } catch(error) {
    console.log('dataif-router destroy error:'+error);
  }
});

router.get('/datapermit', async function(req, res){
  try{
    var result = await dataif_controller.fetchData(req, res);
    res.render('dataif/datapermit', {posts:result});
  } catch(error) {
    console.log('dataif-router /datapermit error:'+error);
  }
});


module.exports = router;