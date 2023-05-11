var db = require('../../utils/db');
// const path = require("path");
var verifyToken = require("../../middleware/verify_token");



exports.getUserById = async function(req) {
    var conn;
    try {
        conn = await db.getConnection();
        // console.log('mobile-user-service getUserById');

        // console.log('getUserById req.idPerson: ', req.idPerson);
        const userdb = await conn.query(`CALL webdb.SP_GET_USER_BY_ID(?);`, [req.idPerson]);
        // console.log(userdb[0][0]);
        const result = userdb[0][0]
        
        return result;
       
        
    } catch (err) {
        console.log('mobile-login-service getUserById:'+ err);
    } finally {
      if(conn) conn.end();
    }
  
  }

  exports.changeEmail = async function(req, res){
    var conn;
    var resultcode = 0;
    try {
        conn = await db.getConnection();
        // console.log('mobile-user-service changeEmail');
        const {currentEmail, newEmail} = req.body;
        // console.log(currentEmail, newEmail);
        await conn.query('UPDATE webdb.tb_user SET user_email = ? WHERE uid = ?', [newEmail, req.idPerson]);
        return resultcode;
        
    } catch (err) {
        console.log('mobile-login-service change-email:'+ err);
    } finally {
      if(conn) conn.end();
    }
  }
  exports.changeExtraInfo = async function(req, res){
    var conn;
    var resultcode = 0;
    try {
        conn = await db.getConnection();
        // console.log('mobile-user-service changeExtraInfo');
        const {emd_class_code, youthAge_code, parentsAge_code, sex_class_code} = req.body;
        // console.log(emd_class_code, youthAge_code, parentsAge_code, sex_class_code);
        // console.log(currentEmail, newEmail);
        await conn.query('UPDATE webdb.tb_user SET emd_class_code = ?, youthAge_code = ?, parentsAge_code = ?, sex_class_code = ? WHERE uid = ?', [emd_class_code, youthAge_code, parentsAge_code, sex_class_code, req.idPerson]);
        return resultcode;
        
    } catch (err) {
        console.log('mobile-login-service change-extra-info:'+ err);
    } finally {
      if(conn) conn.end();
    }
  }

  /*
  export const changePassword = async (req: Request, res: Response): Promise<Response> => {

    try {

        const { currentPassword, newPassword }: IChangePassword = req.body;

        const conn = await connect();

        const passdb = await conn.query<RowDataPacket[]>('SELECT passwordd FROM users WHERE person_uid = ?', [req.idPerson]);

        if( ! bcrypt.compareSync( currentPassword, passdb[0][0].passwordd ) ){
            return res.status(400).json({
                resp: false,
                message: 'La contraseña no coincide'
            });
        }

        const salt = bcrypt.genSaltSync();
        const newPass = bcrypt.hashSync( newPassword, salt );

        await conn.query('UPDATE users SET passwordd = ? WHERE person_uid = ?', [ newPass, req.idPerson ]);

        conn.end();

        return res.json({
            resp: true,
            message: 'Password changed successfully',
        });

    } catch(err) {
        return res.status(500).json({
            resp: false,
            message: err
        });
    }

} */