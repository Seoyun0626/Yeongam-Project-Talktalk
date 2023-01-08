const LocalStrategy = require('passport-local').Strategy;
const passport = require('passport');
var bkfd2Password = require("pbkdf2-password");
var hasher = bkfd2Password();
var db = require('../utils/db');


//변경점 있음
module.exports = () => {
    passport.use('local-login', new LocalStrategy({
        usernameField: 'userid',
        passwordfield: 'password', //req.body.password
        passReqToCallback: true, //req를 콜백함수로 넘길지 여부
    }, async function(req, username, password, done) {
        var conn;
        try{
            db.getConnection(function(err, connection) {
                if (err) {
                    console.log('db.getConnection error:'+err);
                    return done(null, false, {'message': '입력정보가 정확하지 않습니다.'});
                }
                conn = connection;
                //console.log(conn);
                const query = 'SELECT userid, password, salt, name FROM webdb.tb_user where userid="'+username+'"';
                conn.query(query, function(err, rows) {
                    if (err) {
                        console.log('db.query error:'+err);
                        return done(null, false, {'message': '입력정보가 정확하지 않습니다.'});
                    }
                    if (rows.length) {
                        var user = rows[0]; // 적절한 유저정보가 존재하는 경우
                        return hasher(
                            { password: password, salt: user.salt },
                            function (err, pass, salt, hash) {
                                if (hash === user.password) { // 사용자의 비밀번호가 올바른지 확인
                                    console.log('passport user:', user);
                                    done(null, user); // user 라는 값을 passport.serializeUser의 첫번째 인자로 넘김
                                } else {
                                    console.log('password error');
                                    done(null, false, {'message': '입력정보가 정확하지 않습니다.'});
                                }
                            });
                        //return done(null, {'userid': rows[0].userid})
                    } else {
                        console.log('userid error');
                        return done(null, false, {'message': '입력정보가 정확하지 않습니다.'});
                    }
                });
            });
        } catch(error) {
            console.log('passport login:'+error);
            return done(error);
        } finally {
            if (conn) {
                conn.release();
            }
        }
    }));
    //serialize 부분을 작성해야 server.js의 post에서 call한
    //passport.authenticate 함수가 정상 작동한다.

    passport.serializeUser((user,done)=>{ // user 라는 값을 passport.serializeUser의 첫번째 인자로 전송
        console.log('serializeUser:'+user);
        done(null,user);
    });

    passport.deserializeUser((user,done)=>{
        //console.log('deserializeUser:'+user);
        done(null,user);
    });
}