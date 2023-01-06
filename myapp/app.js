const express = require('express');
const path = require('path');
const mysql = require('mysql');
const {promisfy} = require('promisfy');
const bodyParser = require('body-parser');
const http  = require('http');

const routesUser =require('../myapp/src/routes/auth_routes');
const routesAuth =  require('../myapp/src/routes/user_routes');

const app = express();
const port = 3000;
// const dbConfig = require('./db.config');
const connect = require('../database/connection');
app.use(express.json());


var cors = require('cors');

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended:true}));


app.get('/', (req, res) => {
  res.send('Hello World!!!')
})





// app.get('/get', function(req, res){
//   var sql = 'select * from tb_user';
//   con.query(sql, function(err, id, fields){
//     if(id){
//       var sql = 'select * from tb_user'
//       con.query(sql, function(err, id, fields){
//         if(err) {
//           console.log(err);
//         }else{
//           res.json(id);
//           console.log('user:', user_id);
//           console.log('user:', fields);
//         }
//       })
//     }
//   })
// })





app.post('/user', (req, res) => {
     res.json({
        resp: true,
        message : '성공적으로 등록된 사용자'
    });
  })

app.post('/auth-login', (req, res) => {
    res.json({
      resp:true,
      message : '로그인 성공'
    })
})




// app.post('/user', async (req, res) => {
//   const user_id = req.body.user_id;
//   const user_name = req.body.user_name;
//   const user_pw = req.body.user_pw;
//   const user_email = req.body.user_email;

//   await db.query("INSERT INTO test (user_id, user_name, user_email, user_pw) VALUES (?);", [user_id, user_name, user_email, user_pw]);
//   res.json({status:"OK"});
// })



app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})

// const pool = mysql.createPool({
//   host: dbConfig.HOST,
//   user: dbConfig.USER,
//   password: dbConfig.PASSWORD,
//   port:dbConfig.PORT,
//   database: dbConfig.DATABASE,
// });


// pool.getConnection(function(err){
//   if(err) throw err;
//   console.log('connectttttted!');
// })

pool.getConnection(function(err, connection){  
  if( err ){
      if( err.code === 'PROTOCOL_CONNECTION_LOST' ) console.log('DATABASE CONNECTION WAS CLOSED');
      if( err.code === 'ER_CON_COUNT_ERROR' ) console.log('DATABASE HAS TO MANY CONNECTIONS');
      if( err.code === 'ECONNREFUSED' ) console.log('DATABASE CONNECTION WAS REFUSED');
  }
  
  if( connection ) connection.release();

  console.log('DataBase is connected to '+ dbConfig.DATABASE);
  return;
});


class App {

  constructor() {
      this.apiRoutes = {
          user: '/api',
          auth: '/api',
          // post: '/api',
          // notification: '/api',
          // story: '/api',
          // chat: '/api',
      };
      this.app = express();
      this.httpServer = createServer(this.app);
      this.middlewares();
      this.routes();
      this.configServerSocket();
  }
  middlewares() {
      this.app.use(cors());
      this.app.use(express.json());
      this.app.use(express.urlencoded({ extended: false }));
      // this.app.use(express.static(path.resolve('uploads/profile')));
      // this.app.use(express.static(path.resolve('uploads/profile/cover')));
      // this.app.use(express.static(path.resolve('uploads/posts')));
      // this.app.use(express.static(path.resolve('uploads/stories')));
  }
  routes() {
      this.app.use(this.apiRoutes.user, routesUser);
      this.app.use(this.apiRoutes.auth, routesAuth);
      // this.app.use(this.apiRoutes.post, routesPost);
      // this.app.use(this.apiRoutes.notification, routesNotifications);
      // this.app.use(this.apiRoutes.story, routesStory);
      // this.app.use(this.apiRoutes.chat, routesChat);
  }
  // configServerSocket() {
  //     const io = new ServerSocket(this.httpServer);
  //     socketChatMessages(io);
  // }
  // async listen(port) {
  //     await this.httpServer.listen(port);
  //     console.log(`SERVER RUN ON PORT ${port}`);
  // }
}

pool.query = promisfy(pool.query);


module.exports = app;
