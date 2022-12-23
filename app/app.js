//모듈
const express = require('express');
const bodyParser = require('body-parser');
const dotenv = require("dotenv");
dotenv.config();

const app = express();
const session = require("express-session");
const passport = require('passport');
const flash = require('express-flash');
const initPassport = require('./src/utils/passport');

//라우팅
const routerAdmin = require("./src/routes/admin-router/dataif-router");
const routerMobile = require("./src/routes/mobile-router");

//앱 세팅
app.set("views", "./src/views");
app.set("view engine", "ejs");

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
initPassport();
app.use(flash());

app.use(express.static(`${__dirname}/src/public`)); //정적파일 경로
app.use(bodyParser.json()); //json형식의 데이터를 받을 수 있게
app.use(bodyParser.urlencoded({ extended: true })); //urlencoded형식의 데이터를 받을 수 있게
app.use("/admin",routerAdmin);
app.use("/mobile",routerMobile);

module .exports = app;