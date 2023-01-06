// const express = require('express');
// const path = require('path');
// const mysql = require('mysql');
// const {promisfy} = require('promisfy');
// const bodyParser = require('body-parser');

// const app = express();
// const dbConfig = require('./db.config');
// const port = 3000;
// app.use(express.json());

// var cors = require('cors');

// app.use(bodyParser.json());
// app.use(bodyParser.urlencoded({extended:true}));


// // var con = mysql.createConnection({
// //     host: '127.0.0.1',
// //     user: 'root',
// //     password: '1004',
// //     port:3306,
// //     database: 'webdb'
// // });

// // con.connect(function(err){
// //     if (err) throw err;
// //     console.log('Connected~');
// // })

// const pool = mysql.createPool({
//     host: dbConfig.HOST,
//     user: dbConfig.USER,
//     password: dbConfig.PASSWORD,
//     port:dbConfig.PORT,
//     database: dbConfig.DATABASE,
// });


// pool.getConnection(function(err){
//     if(err) throw err;
//     console.log('connectttttted!');
// })

// pool.getConnection(function(err, connection){  
//     if( err ){
//         if( err.code === 'PROTOCOL_CONNECTION_LOST' ) console.log('DATABASE CONNECTION WAS CLOSED');
//         if( err.code === 'ER_CON_COUNT_ERROR' ) console.log('DATABASE HAS TO MANY CONNECTIONS');
//         if( err.code === 'ECONNREFUSED' ) console.log('DATABASE CONNECTION WAS REFUSED');
//     }
    
//     if( connection ) connection.release();

//     console.log('DataBase is connected to '+ dbConfig.DATABASE);
//     return;
// });

// pool.query = promisfy(pool.query);

// module.exports = app;
