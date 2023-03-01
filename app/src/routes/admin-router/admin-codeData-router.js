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

router.get('/update/:id', async function (req, res) {
    try{
        // console.log(req.params.id);
        var code_data = await code_controller.getCodeData_update(req, res);
        // var result = await code_controller.fetchData(req,res);
        // console.log(code_data);
        res.render('codeData/update', {
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

router.get('/detail/update/:id', async function (req, res) {
    try{
        // console.log(req.params.id);
        var code_data = await code_controller.getCodedetail_update(req, res);
        // var result = await code_controller.fetchData(req,res);
        // console.log(code_data);
        var common_code = req.params.id.split(':')[1];
        var detail_code = req.params.id.split(':')[2];
        // console.log(code_data);
        res.render('codeData/detailUpdate', {
            code_data:code_data,
            params:req.params.id,
            common_code:common_code,
            detail_code:detail_code,
            // posts:result,
            // user:req.user
        });
    }
    catch(error) {
        console.log('policy-router show error:'+error);
    }
  }
);

router.post('/detail/update/:id', async function (req, res) {
    try{
        // 공통 코드 수정 쿼리
        var code_data = await code_controller.updateCodeDetail(req, res);
        // var code_data = await code_controller.getCodedetail_update(req, res);
        // console.log(code_data);
        var common_code = req.params.id.split(':')[1];
        var detail_code = req.params.id.split(':')[2];
        res.redirect('/admin/codeData/detail/'+common_code+'');
        // console.log(code_data);
        // res.render('codeData/detailUpdate', {
        //     code_data:code_data,
        //     params:req.params.id,
        //     common_code:common_code,
        //     detail_code:detail_code,
        //     // posts:result,
        //     // user:req.user
        // });
    }
    catch(error) {
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

router.post('/detail/insert/:id', async function (req, res) {
    try{
        // console.log(req.params.id);
        var code_data = await code_controller.insertCodeDetail(req, res);
        // var result = await code_controller.fetchData(req,res);
        // console.log(code_data);
        res.redirect('/admin/codeData/detail/'+req.params.id.split(':')[1]+'');
    }
    catch(error) {
        console.log('policy-router show error:'+error);
    }
    }
);

module.exports = router;