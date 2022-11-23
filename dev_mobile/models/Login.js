const Sequelize = require('sequelize');

module.exports = class Login extends Sequelize.Model{
    static init(sequelize) {
        return super.init({
            user_no : {
                type : Sequelize.INTEGER,
                allowNull : false
            },
            user_id : {
                type : Sequelize.STRING(20),
                allowNull : false,
            },
            user_pw : {
                type : Sequelize.STRING(20),
                allowNull : false,
            },
            provider : {
                type: Sequelize.STRING(10),
                allowNull : false,
                defaultValue :  'local'
            },// 'local'이면 로컬 로그인, 'kakao'이면 카카오 로그인
        }, {
            sequelize,
            timestamps : true,
            underscored : false,
            modelName : 'User',
            tableName : 'TB_LOGIN',
            paranoid : true,
            charset : 'utf8',
            collate : 'utf8_general_ci',
        });
    }

    static associate(db) {
        
      }
};
