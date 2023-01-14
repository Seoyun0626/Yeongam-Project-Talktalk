//공용 모듈1
const express = require('express');
const bodyParser = require('body-parser');
const dotenv = require("dotenv");

//모바일 모듈
const cors = require('cors');
const path = require('path');
const createServer = require('http');
const {promisfy} = require('promisfy');

dotenv.config();

const app = express();
const session = require("express-session");
const passport = require('passport');
const flash = require('express-flash');
const initPassport = require('./src/utils/passport');

// const port = process.env.PORT;

// app.listen(port, () => {
//   console.log(`APP : SERVER RUN ON PORT ${port}`)
// })
app.get('/welcome', (req, res)=>{
  res.send('heehee');
})
//라우팅
// const routeUser = require('./src/routes/mobile-router/user_routes');
// const routeAuth = require('./src/routes/mobile-router/auth_routes');
const routerAdminDataif = require("./src/routes/admin-router/admin-dataif-router");
const routerAdminLogin = require("./src/routes/admin-router/admin-login-router");
const routerMobile = require("./src/routes/mobile-router/mobile-router");
const routerAdminMain = require("./src/routes/admin-router/admin-main-router");

//앱 세팅
app.set("views", "./src/views"); //템플릿 파일 경로(views)
app.set("view engine", "ejs"); //템플릿 엔진(ejs)

app.use(session({
    secret: "eqz9rPfMT8qO+EUHFW",
    resave: false, 
    saveUninitialized: true,
    rolling: true,
    cookie: {
      secure: true,
      expires: 600 * 1000
   }
  }));

app.use(passport.initialize());
app.use(passport.session());

/*
app.use(express.static('src/public'))
app.use('/js', express.static('public/js'));
app.use('/public/upload', express.static('src/public/upload'));
app.use('/js', express.static(path.join(__dirname, 'public/js')));
// app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));

// app.use(methodoverride('_method'));
*/
initPassport();
app.use(flash());

app.use(express.static(`${__dirname}/src/public`)); //정적파일 경로

app.use(bodyParser.json()); //json형식의 데이터를 받을 수 있게
app.use(bodyParser.urlencoded({ extended: true })); //urlencoded형식의 데이터를 받을 수 있게

// app.use(cors());
app.use("/admin/dataif",routerAdminDataif); //관리자 데이터 인터페이스
app.use("/admin/auth",routerAdminLogin); //관리자 로그인
app.use("/admin/main",routerAdminMain); //관리자 메인

app.use("/mobile",routerMobile); // 모바일

module .exports = app;



