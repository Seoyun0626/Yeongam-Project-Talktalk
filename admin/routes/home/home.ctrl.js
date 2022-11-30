const { response } = require('express');
const user = require('../../models/User');
const User_data = require('../../models/User_data');

//더미 데이터, sql로 대체할 것
const userinfo = require('../../db/info.json');

const output = {
    regiMem : (req, res) => {
        res.render('regiMem');
    },
    revMem : (req, res) => {
        res.render('revMem');
    },
    deleteMem : (req, res) => {
        res.render('deleteMem');
    },
    regiAll : (req, res) => {
        res.render('regiAll');
    },
    member_management : (req, res) => {
        res.render('member_management');
    },
    mem : (req,res)=>{
        res.render('mem',{
            userinfo
        });
    },
    login : (req, res) => {
        res.render("home/index");
    }
}
const process = {
    login : (req, res) => {
        const user = new user(req.body);
        const response = user.login();
        return res.json(response);
}}


module.exports = {
    output,
    process
}