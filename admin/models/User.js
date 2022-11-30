const User_data = require('../models/User_data');

class User{
    constructor(body){
        this.body = body;
    }

    login(){
        const body = this.body;
        const {id,password} =  User_data.getUserInfo(body.id);
        if(id){
            if(id === body.id && password === body.password){
                return {success : true};
            }
            return {success : false, msg : "비밀번호가 틀렸습니다."};
        }
        return {success : false, msg : "존재하지 않는 아이디입니다."};
    }
}
module.exports = User;