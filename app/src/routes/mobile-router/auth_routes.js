const Router =require('express');
const auth = require('../../controllers/mobile-controller/auth_controller');
const verifyToken = require('../../middleware/verify_token');
const router = Router();


router.post('/auth-login', auth.login);
router.get('/auth/renew-login', verifyToken, auth.renewLogin);

module.exports = router;
// export default router;