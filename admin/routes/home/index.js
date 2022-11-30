// routes/index.js
const router = require("express").Router();

const ctrl  = require("./home.ctrl");

router.get('/',ctrl.output.login);
router.post('/',ctrl.process.login);

router.get('/mem',ctrl.output.mem);
router.get('/member_management',ctrl.output.member_management);
router.get('/regiAll',ctrl.output.regiAll);
router.get('/regiMem',ctrl.output.regiMem);
router.get('/revMem',ctrl.output.revMem);
router.get('/deleteMem',ctrl.output.deleteMem);
router.use((req, res) => {
    res.sendFile(__dirname ,'../404.html');
});
module.exports = router;