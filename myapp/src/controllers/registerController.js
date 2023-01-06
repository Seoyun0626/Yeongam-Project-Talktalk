// const express = require('express');
// const bcrypt = require('bcrypt');
// import pool from '../db.js'

// export const registerUser = async(req, res = response) => {
//     const {user_id, user_pw, user_name, user_eamil} = req.body;
    
//     try {
//         let salt = bcrypt.genSaltSync();
//         const pass = bcrypt.hashSync(user_pw, salt);

//         const validatedEmail = await pool.query('SELECT email FROM tb_user WHERE email = ?', [user_eamil]);

//         // if (validatedEmail.length > 0) {
//         //     return res.status(401).json({
//         //         resp : false,
//         //         msg : '이메일이 이미 존재합니다.'
//         //     });
//         // }

//         await pool.query('')
        
//     } catch (err) {
//         return res.status(401).json({
//             resp : false,
//             msg : "이메일이 이미 존재합니다."
//         })
//     }
// }
