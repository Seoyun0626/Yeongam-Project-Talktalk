import { Request, Response } from 'express';
import { RowDataPacket } from 'mysql2';
import bcrypt from 'bcrypt';
import { SignIn } from "../interfaces/login_interface";
import { connect } from '../database/connection';
import { generateJsonWebToken } from '../lib/generate_jwt';
import { IVerifyUser } from '../interfaces/userdb';
// import { sendEmailVerify } from '../lib/nodemail';


export const login = async ( req: Request, res: Response): Promise<Response> => {

    try {

        const { user_id, user_pw }: SignIn = req.body;

        const conn = await connect();

        // Check is exists user_id on database 
        const [verifyUserdb] = await conn.query<RowDataPacket[0]>('SELECT user_id, user_pw, FROM users WHERE user_id = ?', [user_id]);

        if(verifyUserdb.length == 0){
            return res.status(401).json({
                resp: false,
                message: '등록되지 않았습니다.'
            });
        }

        const verifyUser: IVerifyUser = verifyUserdb[0];

        // // Check Email is Verified
        // if( !verifyUser.email_verified ){
        //     resendCodeEmail(verifyUser.user_id);
        //     return res.status(401).json({
        //         resp: false,
        //         message: '메일을 확인해주세요.'
        //     });
        // }

        // Check Password
        // if( !await bcrypt.compareSync( user_pw, verifyUser.user_pw )){
        //     return res.status(401).json({
        //         resp: false,
        //         message: '잘못된 비밀번호입니다.'
        //     });
        // }
        
        const uidPersondb = await conn.query<RowDataPacket[]>('SELECT person_uid as uid FROM users WHERE email = ?', [user_id]);

        const { uid } = uidPersondb[0][0];

        let token = generateJsonWebToken( uid );

        conn.end();
        
        return res.json({
            resp: true,
            message: '환영합니다.',
            token: token
        });
        
    } catch (err) {
        return res.status(500).json({
            resp: false,
            message: err
        });
    }

}

export const renweLogin = async ( req: Request, res: Response ) => {

    try {

        const token = generateJsonWebToken( req.idPerson );

        return res.json({
            resp: true,
            message: '환영합니다.',
            token: token
        }); 
        
    } catch (err) {
        return res.status(500).json({
            resp: false,
            message: err
        });
    }    

}


const resendCodeEmail = async (email: string): Promise<void> => {

    const conn = await connect();

    var randomNumber = Math.floor(10000 + Math.random() * 90000);

    await conn.query('UPDATE users SET token_temp = ? WHERE email = ?', [ randomNumber, email ]);

    // await sendEmailVerify('Codigo de verificación', email, `<h1> Social Frave </h1><hr> <b>${ randomNumber } </b>`);

    conn.end();

}