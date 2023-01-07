<<<<<<< Updated upstream
//공용 모듈
const express = require('express');
const bodyParser = require('body-parser');
const dotenv = require("dotenv");

//모바일 모듈
const cors = require('cors');
const path = require('path');
const createServer = require('http');
const {promisfy} = require('promisfy');

=======
//모듈
const express = require('express');
const bodyParser = require('body-parser');
const dotenv = require("dotenv");
>>>>>>> Stashed changes
dotenv.config();

<<<<<<< Updated upstream
const app = express();
const session = require("express-session");
const passport = require('passport');
const flash = require('express-flash');
const initPassport = require('./src/utils/passport');

//라우팅
<<<<<<< Updated upstream
// const routeUser = require('./src/routes/mobile-router/user_routes');
// const routeAuth = require('./src/routes/mobile-router/auth_routes');
const routerAdmin = require("./src/routes/admin-router/dataif-router");
const routerMobile = require("./src/routes/mobile-router/user_routes");
=======
const routerAdmin = require("./src/routes/admin-router/dataif-router");
const routerMobile = require("./src/routes/mobile-router");
>>>>>>> Stashed changes

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


<<<<<<< Updated upstream
=======
// kth
// const express = require('express');
// const cors = require('cors');
// const path = require('path');
// const createServer = require('http');
// const {promisfy} = require('promisfy');
// const bodyParser = require('body-parser');
>>>>>>> Stashed changes
=======
// ====test======
// const app = express();
// port = 3000;

// app.get('/', (req, res) => {
//   res.send('Hello World!!!')
// })

// app.post('/user', (req, res) => {
//   res.json({
//      resp: true,
//      message : '성공적으로 등록된 사용자'
//  });
// })

// app.post('/auth-login', (req, res) => {
//  res.json({
//    resp:true,
//    message : '로그인 성공'
//  })
// })

// app.listen(port, () => {
//   console.log(`Example app listening on port ${port}`)
// })
>>>>>>> Stashed changes


// const routeUser = require('./src/routes/mobile-router/user_routes');
// const routeAuth = require('./src/routes/mobile-router/auth_routes');