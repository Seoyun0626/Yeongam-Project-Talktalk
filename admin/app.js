//모듈
const bodyParser = require("body-parser");
const express = require('express');
const hbs = require('express-handlebars');
const userinfo = require('./db/info.json');
const router = require('./routes/home');

//db.js에서 sql받아오기
var db_config = require(__dirname + '/db.js');
var conn = db_config.init();
db_config.connect(conn);
const server = express();

const PORT = 4000;
server.engine("hbs", hbs.engine({
    extname: "hbs",
    defaultLayout: "layout.hbs",
    layoutsDir: __dirname + "/views/layouts",
    partialsDir: __dirname + "/views/partials"
}));

//세팅
server.set("views", __dirname + "/views");
server.set("view engine", "hbs");
server.use(express.static(__dirname + '/public'));
server.use(bodyParser.json());

server.use(bodyParser.urlencoded({ extended: true }));

const home = require('./routes/home');
server.use('/', home);

//PORT로 서버 실행
server.listen(PORT, (err) => {
    if (err) {
        console.log(err);
    }
    console.log('Server running at port 4000');
});