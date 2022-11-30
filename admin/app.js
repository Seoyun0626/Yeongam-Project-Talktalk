//script,css 코드들 분할해서 정리하기

const express = require('express');
const hbs = require('express-handlebars');
const userinfo = require('./db/info.json');

//db.js에서 sql받아오기
var db_config = require(__dirname + '/db.js');
var conn = db_config.init();
db_config.connect(conn);



const server = express();

server.engine("hbs", hbs.engine({
    extname: "hbs",
    defaultLayout: "layout.hbs",
    layoutsDir: __dirname + "/views/layouts",
    partialsDir: __dirname + "/views/partials"
}));

server.set("view engine", "hbs");

server.use(express.static(__dirname + '/public'));

server.get('/', (req, res) => {
    res.render('adm',{
        userinfo
    });
});

server.get('/member_management', (req, res) => {
    res.render('member_management');
});
server.get('/regiAll', (req, res) => {
    res.render('regiAll');
});
server.get('/regiMem', (req, res) => {
    res.render('regiMem');
});
server.get('/revMem', (req, res) => {
    res.render('revMem');
});
server.get('/deleteMem', (req, res) => {
    res.render('deleteMem');
});



server.use((req, res) => {
    res.sendFile(__dirname + '/404.html');
});

server.listen(4000, (err) => {
    if (err) {
        console.log(err);
    }
    console.log('Server running at port 4000');
});