const path = require("path");
var express = require("express");
var router = express.Router();
var code_controller = require("../../controllers/common-controller/codeData-controller");

router.get('/show', async function (req, res) {
    try{
        var code_data = await code_controller.getCodeData(req, res);
        res.render('codeData/show', {
            code_data:code_data,
        });
    } catch(error) {
        console.log('policy-router show error:'+error);
    }
  }
);

router.get('/detail/:id', async function (req, res) {
    try{
        // console.log(req.params.id);
        var code_data = await code_controller.getCodedetail(req, res);
        // var result = await code_controller.fetchData(req,res);
        // console.log(code_data);
        res.render('codeData/detail', {
            code_data:code_data,
            params:req.params.id,
            // posts:result,
            // user:req.user
        });
    }
    catch(error) {
        console.log('policy-router show error:'+error);
    }
  }
);


module.exports = router;