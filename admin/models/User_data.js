class User_data{
    //임시 더미 데이터
    //#으로 private(model외부에서 접근 불가)로 선언
    static #users = {
        id : ["admin1", "admin2", "admin3"],
        password : ["1234", "1234", "1234"],
        name : ["관리자1", "관리자2", "관리자3"],
        phone : ["010-1234-1234", "010-1234-1234", "010-1234-1234"]
    }
    static getUser(...fields){
        const user = this.#users;
        const newuser = fields.reduce((newuser, field)=>{
            if(user.hasOwnProperty(field)){
                newuser[field] = user[field];
            }
            return newuser;
        }, {});
        return newuser;
    }
    static getUserInfo(id){
        const users = this.#users;
        const idx = users.id.indexOf(id);
        const userKeys = Object.keys(users);
        const userInfo = userKeys.reduce((newuser, info)=>{
            newuser[info] = users[info][idx];
            return newuser;
        }, {});
        
        return userInfo;
    }
}
module.exports = User_data;