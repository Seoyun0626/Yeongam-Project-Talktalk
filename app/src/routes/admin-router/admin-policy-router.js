const path = require("path");
var express = require("express");
var router = express.Router();
var policy_controller = require("../../controllers/common-controller/policy-controller");

const passport = require('passport');

// const { isLoggedIn, isNotLoggedIn } = require('../lib/auth');
router.get('/show', function (req, res) {
    try{
      res.render('policy/show');
    } catch(error) {
        console.log('policy-router show error:'+error);
    }
  });

router.get('/upload', function (req, res) {
    try{
        res.render('policy/upload');
        }
    catch(error) {
        console.log('policy-router upload error:'+error);
    }
});
  




module.exports = router;