var db = require("../../utils/db");
var bkfd2Password = require("pbkdf2-password");
var hasher = bkfd2Password();
// const path = require("path");
// var verifyToken = require("../../middleware/verify_token");

exports.getUserById = async function (req) {
  var conn;
  try {
    conn = await db.getConnection();
    // console.log('mobile-user-service getUserById');
    // console.log('getUserById req.idPerson: ', req.idPerson); // uid
    const userdb = await conn.query(`CALL webdb.SP_GET_USER_BY_ID(?);`, [
      req.idPerson,
    ]);
    // console.log(userdb[0][0]);
    const result = userdb[0][0];

    return result;
  } catch (err) {
    console.log("mobile-login-service getUserById:" + err);
  } finally {
    if (conn) conn.release();
  }
};

//   export const changePassword = async (req: Request, res: Response): Promise<Response> => {

//     try {

//         const { currentPassword, newPassword }: IChangePassword = req.body;

//         const conn = await connect();

//         const passdb = await conn.query<RowDataPacket[]>('SELECT passwordd FROM users WHERE person_uid = ?', [req.idPerson]);

//         if( ! bcrypt.compareSync( currentPassword, passdb[0][0].passwordd ) ){
//             return res.status(400).json({
//                 resp: false,
//                 message: 'La contraseña no coincide'
//             });
//         }

//         const salt = bcrypt.genSaltSync();
//         const newPass = bcrypt.hashSync( newPassword, salt );

//         await conn.query('UPDATE users SET passwordd = ? WHERE person_uid = ?', [ newPass, req.idPerson ]);

//         conn.end();

//         return res.json({
//             resp: true,
//             message: 'Password changed successfully',
//         });

//     } catch(err) {
//         return res.status(500).json({
//             resp: false,
//             message: err
//         });
//     }

// }

exports.changePassword = async function (req, res) {
  var conn;
  var resultcode = 0;
  try {
    const uid = req.idPerson;
    conn = await db.getConnection();
    console.log(req.body);
    const { currentPass, newPass } = req.body;

    // 현재 비밀번호 확인
    // 사용자 정보(비밀번호, salt)
    const userdb = await conn.query(
      "SELECT userpw, salt FROM webdb.tb_user WHERE uid= ?;",
      [uid]
    );

    if (userdb && userdb[0]) {
      var userPass = userdb[0].userpw;
      var userSalt = userdb[0].salt;
      const result = await new Promise((resolve, reject) => {
        hasher(
          {
            password: currentPass,
            salt: userSalt,
          },
          async (err, pass, salt, hash) => {
            if (err) {
              console.log("mobile-user-service change password:" + err);
              resultcode = 200; // 암호화 오류 발생
            } else if (hash !== userPass) {
              resultcode = 100; // 현재 비밀번호 불일치
            } else {
              // 현재 비밀번호 일치 -> 새 비밀번호와 다른지 확인
              hasher(
                { password: newPass },
                async function (err, pass, salt, hash) {
                  if (err) {
                    console.log("mobile-user-service change password:" + err);
                    resultcode = 200; // 암호화 오류 발생
                  } else if (hash === userPass) {
                    resultcode = 300; // 새 비밀번호와 현재 비밀번호 일치: 비밀번호 변경 불가
                  } else {
                    try {
                      // 새 비밀번호 변경, salt값도 변경
                      query =
                        "UPDATE webdb.tb_user SET userpw= ? , salt= ? WHERE uid= ?";
                      rows = await conn.query(query, [hash, salt, uid]); // 쿼리 실행
                      resultcode = 1; // 비밀번호 변경 성공
                      console.log(
                        "mobile-user-service change password:" + resultcode
                      );
                    } catch (error) {
                      console.log(
                        "mobile-user-service change password:" + error
                      );
                      resultcode = 200; // 쿼리 실행 에러
                    }
                  }
                  resolve(resultcode);
                }
              );
            }
            resolve(resultcode);
          }
        );
      });
    }
    return resultcode;
  } catch (err) {
    console.log("mobile-login-service change-password:" + err);
  } finally {
    if (conn) conn.release();
  }
};

exports.changeEmail = async function (req, res) {
  var conn;
  var resultcode = 0;
  try {
    conn = await db.getConnection();
    // console.log('mobile-user-service changeEmail');
    const { currentEmail, newEmail } = req.body;
    // console.log(currentEmail, newEmail);
    await conn.query("UPDATE webdb.tb_user SET user_email = ? WHERE uid = ?", [
      newEmail,
      req.idPerson,
    ]);
    return resultcode;
  } catch (err) {
    console.log("mobile-login-service change-email:" + err);
  } finally {
    if (conn) conn.release();
  }
};
exports.changeExtraInfo = async function (req, res) {
  var conn;
  var resultcode = 0;
  try {
    conn = await db.getConnection();
    // console.log('mobile-user-service changeExtraInfo');
    const { emd_class_code, youthAge_code, parentsAge_code, sex_class_code } =
      req.body;
    // console.log(emd_class_code, youthAge_code, parentsAge_code, sex_class_code);
    // console.log(currentEmail, newEmail);
    await conn.query(
      "UPDATE webdb.tb_user SET emd_class_code = ?, youthAge_code = ?, parentsAge_code = ?, sex_class_code = ? WHERE uid = ?",
      [
        emd_class_code,
        youthAge_code,
        parentsAge_code,
        sex_class_code,
        req.idPerson,
      ]
    );
    return resultcode;
  } catch (err) {
    console.log("mobile-login-service change-extra-info:" + err);
  } finally {
    if (conn) conn.release();
  }
};

exports.getFigCount = async function (req, res) {
  var conn;
  try {
    conn = await db.getConnection();
    var uid = req.idPerson;
    query = 'select fig from webdb.tb_user where uid = "' + uid + '";';
    rows = await conn.query(query); // 쿼리 실행
    return rows;
  } catch (error) {
    console.log("mobile-user-service getFigCount:" + error);
  } finally {
    if (conn) conn.release();
  }
};

exports.saveWithdrawalLog = async function (req, res) {
  var conn;
  try {
    conn = await db.getConnection();
    var code = req.body.withdrawal_reason_code;
    var etc = req.body.etc;

    var query = `INSERT INTO webdb.tb_withdrawal_logs (withdrawal_reason_code, withdrawal_date, etc) VALUES (?, CURRENT_TIMESTAMP, ?)`;
    var result = await conn.query(query, [code, etc]);
    return result;
  } catch (error) {
    console.log("mobile-user-service saveWithdrawalLog:" + error);
  } finally {
    if (conn) conn.release();
  }
};

exports.deleteUser = async function (req, res) {
  var conn;
  try {
    conn = await db.getConnection();
    // console.log('mobile-user-service delete user :'+req.idPerson);
    var uid = req.idPerson;
    // console.log(uid);

    // 유저의 스크랩 목록 받아오기
    const scrapQuery = "SELECT * FROM webdb.tb_policy_scrap WHERE user_uid = ?";
    const scrapRows = await conn.query(scrapQuery, [uid]); // 스크랩 목록

    // 유저의 스크랩 policy_uid에 따라 스크랩 수 감소
    for (var i = 0; i < scrapRows.length; i++) {
      const policy_uid = scrapRows[i].policy_uid;
      const policyQuery =
        "UPDATE webdb.tb_policy SET count_scraps = count_scraps - 1 WHERE uid = ?"; // 스크랩 수 감소
      await conn.query(policyQuery, [policy_uid]);
    }

    const deletePolicyScrapQuery =
      "DELETE FROM webdb.tb_policy_scrap WHERE user_uid = ?";
    await conn.query(deletePolicyScrapQuery, [uid]);
    const deleteUserQuery = "DELETE FROM webdb.tb_user WHERE uid = ?";
    await conn.query(deleteUserQuery, [uid]);
    return rows;
  } catch (error) {
    console.log("mobile-user-service delete user:" + error);
  } finally {
    if (conn) conn.release();
  }
};

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

        conn.release();

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
