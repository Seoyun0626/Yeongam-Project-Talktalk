// mysql 모듈 로딩
var mysql = require('mysql');


var pool;

exports.connect = function() {
    pool = mysql.createPool({
        connectionLimit : 100, // 커넥션 풀 최대 개수 100
        host : 'localhost',
        user : 'root',
        password : 'yeongam-proj',
        database : 'yeongam-proj'
    })
}

exports.get = function () {
    return pool;
}