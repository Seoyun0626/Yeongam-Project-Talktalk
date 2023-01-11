// const path = require("path");
var express = require("express");
var router = express.Router();
var main_controller = require("../../controllers/common-controller/main-controller");
var fs = require("fs");
var mime = require('mime-types');
// const auth = require('../utils/auth');
// const utils = require('../utils/utils');

/*
var  controller_main = require("../controllers/main-controller");
router.get("/db", controller_main.GetJsonList);

router.get("/mail_get", function(req, res) {
    res.sendFile(path.join(__dirname, "../public/mail_get.html"));
})

router.get("/mail_post", function(req, res) {
    res.sendFile(path.join(__dirname, "../public/mail_post.html"));
})
*/

/*
router.post("/dashboard", checkAuth, async function(req, res) {
    console.log('dashboard:'+req.user)
    try{
        // 로그인 확인을 위해 컨트롤러 호출
        var result = await main_controller.dashboard(req, res);

        res.render('dashboard', {'id':req.user});
    } catch(error) {
        console.log('main-router dashboard error:'+error);
    }
});
*/

router.get("/filedownload", async function(req, res) {
    try{
        var result;
        var filePath;
        var fileName;
        var mimetype;
        if(req.query.filename) {
            filePath = __dirname + "/../../public/upload/" + req.query.filename;
            console.log('filePath:'+filePath);
            fileName = req.query.filename; // 원본파일명​
        } 
        // else {
        //     result = await main_controller.getFile(req, res);
        //     filePath = __dirname + "/../" + result.file_path;
        //     fileName = result.org_file_name; // 원본파일명​
        //     mimetype = result.mime_type;
        // }
        if(fs.existsSync(filePath)) {
            if(!mimetype) mimetype=mime.lookup(filePath);
            // 응답 헤더에 파일의 이름과 mime Type을 명시한다.(한글&특수문자,공백 처리)
            res.setHeader("Content-Disposition", "attachment;filename=\"" + encodeURI(fileName) + "\"");
            res.setHeader("Content-Type", mimetype);
            // filePath에 있는 파일 스트림 객체를 얻어온다.(바이트 알갱이를 읽어옵니다.)
            var fileStream = fs.createReadStream(filePath);
            // 다운로드 한다.(res 객체에 바이트알갱이를 전송한다)
            fileStream.pipe(res);
            fileStream.on("error", err => {
                console.log(err);
                res.status('404')
                    .header('Content-Type', "text/html")
                    .send(`
                    <!DOCTYPE html>
                    <html lang="en">
                        <head>
                        <script>
                            alert('파일읽기에 실패하였습니다.');
                            history.back()
                        </script>
                        </head>
                        <body>W
                        </body>
                    </html>`
                    )
            });
        }
        else res.status('404')
        .header('Content-Type', "text/html")
        .send(`
        <!DOCTYPE html>
          <html lang="en">
            <head>
              <script>
                alert('파일이 없습니다.');
                history.back()
              </script>
            </head>
            <body>
            </body>
          </html>`
        )
/*
delete
var filePath = __dirname + "/../" + result.file_path; // 삭제할 파일의 위치​
fs.unlink(filePath, function(){
    DBData.remove({"_id":_id}, function(err){ // MongoDB 에서 파일 정보 삭제하기​
        if(err) res.send(err); // 에러 확인
        res.end("ok); // 응답
  });
});
*/

    } catch(error) {
        console.log('main-router filedownload error:'+error);
    }
});
/*
router.get("/project", async function(req, res) {
    try{
        var result = await main_controller.getProject(req, res);
        res.send({data:result});
    } catch(error) {
        console.log('main-router getProject error:'+error);
    }
});

router.get("/subproject/:id", async function(req, res) {
    try{
        var result = await main_controller.getSubproject(req, res);
        res.send({data:result});
    } catch(error) {
        console.log('main-router getSubproject error:'+error);
    }
});

router.get("/useproject", async function(req, res) {
    res.render('main/useproject');
});

router.get("/useprocess", async function(req, res) {
    res.render('main/useprocess');
});

router.get("/developinfo", async function(req, res) {
    res.render('main/developinfo', {sengrpcd:req.query.sengrpcd, prjgrpcd:req.query.prjgrpcd, senurl:req.query.senurl});
});

router.get("/usewebprocess", async function(req, res) {
    res.render('main/usewebprocess');
});

router.get("/powersave", async function(req, res) {
    try{
        var result = await main_controller.getPowersave(req, res);
        res.render('main/powersave', {posts:result});
    } catch(error) {
        console.log('main-router powersave error:'+error);
    }
});

router.get("/index_copy", async function(req, res) {
    res.render('index copy 2');
});

router.post('/getSensorName', async function(req, res){
    try{
        var result = await main_controller.getSensorName(req, res);
        res.json({post: result});
    } catch(error) {
        console.log('main-router getSensorName error:'+error);
    }
});

router.get("/usergroup", async function(req, res) {
    res.render('main/usergroup');
});

router.get("/projectauth", async function(req, res) {
    res.render('main/projectauth');
});

router.get("/subprojectauth", async function(req, res) {
    res.render('main/subprojectauth');
});

router.get("/sensorauth", async function(req, res) {
    res.render('main/sensorauth');
});

router.get("/test1", async function(req, res) {
    res.render('main/test1');
});
*/
// router.post("/test1", async function(req, res) {
//     console.log(req.body);
//     var objVal=req.body.job;
//     var remo=req.body.remo;
//     var gateway;
//     var object;
//     var url;
//     switch(Number(req.body.place)){
//         case 2158: gateway='ep20390020'; switch(Number(remo)) { case 1: object='000D6F00152679EA'; break; case 2: object='000D6F001526727F'; break; } break;
//         case 3101: gateway='ep20390042'; switch(Number(remo)) { case 1: object='000D6F0015268409'; break; case 2: object='000D6F0015266C05'; break; } break;
//         case 3106: gateway='ep20390042'; switch(Number(remo)) { case 1: object='000D6F0015254E82'; break; case 2: object='000D6F00152671F0'; break; } break;
//         case 3107: gateway='ep20390042'; switch(Number(remo)) { case 1: object='000D6F0015266933'; break; case 2: object='000D6F00152683E7'; break; } break;
//         case 3193: gateway='ep20390083'; object='000D6F00152665CD'; break;
//         case 4142: gateway='ep20390013'; switch(Number(remo)) { case 1: object='000D6F001524F5C8'; break; case 2: object='000D6F0015266844'; break; } break;
//         case 4127: gateway='ep20390048'; object='000D6F0015266D42'; break;
//         case 5141: gateway='ep20390482'; switch(Number(remo)) { case 1: object='000D6F0015267DF1'; break; case 2: object='000D6F001526A8F7'; break; } break;
//         case 5143: gateway='ep20390482'; switch(Number(remo)) { case 1: object='000D6F0015267549'; break; case 2: object='000D6F001526781C'; break; } break;
//         case 5145: gateway='ep20390482'; object='000D6F001525389C'; break;
//         case 5147: gateway='ep20390482'; object='000D6F00152670B6'; break;
//         case 6141: gateway='ep20390498'; switch(Number(remo)) { case 1: object='000D6F001526770A'; break; case 2: object='000D6F00152678AF'; break; } break;
//         case 6144: gateway='ep20390498'; switch(Number(remo)) { case 1: object='000D6F00152668EC'; break; case 2: object='000D6F0015266B4F'; break; } break;
//         case 6147: gateway='ep20390498'; switch(Number(remo)) { case 1: object='000D6F0015252132'; break; case 2: object='000D6F0015267E7D'; break; } break;
//     }
//     /*
//     if(req.body.place==3193) {
//         gateway='ep20390083';
//         object='000D6F00152665CD';
//     } else if(req.body.place==6144) {
//         gateway='ep19010498';
//         if(req.body.remo=='1') object='000D6F00152668EC';
//         else if(req.body.remo=='2') object='000D6F0015266B4F';
//     } else {
//         gateway='ep17140242';
//         object='000D6F0015268396';
//     }*/

//     var prmData;
//     switch(Number(objVal)){
//         case 1: prmData = '<ctname>11</ctname><head><gateway>'+gateway+'</gateway><body><setAircon><object>'+object+'</object><endpoint>1</endpoint><mode>off</mode></setAircon></body></head>';
//         break;
//         case 2: prmData = '<ctname>11</ctname><head><gateway>'+gateway+'</gateway><body><setAircon><object>'+object+'</object><endpoint>1</endpoint><mode>on</mode></setAircon></body></head>';
//         break;
//         case 3: prmData = '<ctname>11</ctname><head><gateway>'+gateway+'</gateway><body><setAircon><object>'+object+'</object><endpoint>1</endpoint><mode>heat</mode></setAircon></body></head>';
//         break;
//         case 4: prmData = '<ctname>11</ctname><head><gateway>'+gateway+'</gateway><body><setAircon><object>'+object+'</object><endpoint>1</endpoint><mode>cool</mode></setAircon></body></head>';
//         break;
//         case 5: prmData = '<ctname>11</ctname><head><gateway>'+gateway+'</gateway><body><setAircon><object>'+object+'</object><endpoint>1</endpoint><setpoint>'+document.getElementById("temp").value+'</setpoint></setAircon></body></head>';
//         break;
//     }
//     console.log(prmData)
//     var unirest = require('unirest');
//     if(req.body.place=='') url='http://210.94.199.139:17579/Mobius/dgusc_210/actuator_data';
//     else url='http://210.94.199.140:7579/Mobius/dgusc_210/actuator_data';
//     console.log(url)
//     var req = unirest('POST', url)
//     .headers({
//         'Accept': 'applicaton/xml','Content-Type': 'application/vnd.onem2m-res+xml;ty=4',
//         'X-M2M-RI': '12345',
//         'X-M2M-Origin': 'SOrigin'
//     })
//     .send(makeXML(prmData))
//     .end(function (res) {
//         console.log('############################send to noti');
//     });
//     res.json({success: true});
// });

// function makeXML(content) {
//     var xml = "";

//     xml += "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
//     xml += "<m2m:cin ";
//     xml += "xmlns:m2m=\"http://www.onem2m.org/xml/protocols\" ";
//     xml += "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">";
//     xml += "<cnf>text</cnf>";
//     xml += "<con>" + content + "</con>";
//     xml += "</m2m:cin>";

//     return xml;
// }

// router.post("/api/control", auth, async function(req, res) {
//     var result = await main_controller.getControlCommand(req, res);
//     req.body.ctrl_cmd=result.ctrl_cmd;
//     utils.sendDataApi(req);
//     res.status(200).json({
//         success: true
//     });
// });

// router.get("/test111", async function(req, res) {
//     req.body.sensorid="000100010000000005";
//     var result = await main_controller.getControlCommand(req, res);
//     req.body.ctrl_cmd=result.ctrl_cmd;
//     req.body.mode="sel";
//     req.body.val=req.query.val;
//     req.body.endpoint="1";
//     console.log(req.body)
//     utils.sendDataApi(req);
//     res.status(200).json({
//         success: true
//     })
// });

module.exports = router;