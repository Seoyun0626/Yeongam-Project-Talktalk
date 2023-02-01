const path = require("path");
var express = require("express");
var router = express.Router();
var codeData_controller = require("../../controllers/common-controller/codeData-controller");

router.get('/show', async function (req, res) {
    try{
        // var result = await codeData_controller.fetchData(req,res);
        res.render('codeData/show', {
            // posts:result,
            // user:req.user
        });
    } catch(error) {
        console.log('policy-router show error:'+error);
    }
  }
);


module.exports = router;