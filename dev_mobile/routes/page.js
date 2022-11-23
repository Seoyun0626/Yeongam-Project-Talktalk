const express = require('express');

const router = express.Router();

// 라우터용 미들웨어 만들어 템플릿 엔진에서 사용할 변수 res.locals로 설정
router.use((req, res, next) => {
    res.locals.user = null;
    next();
});

// 회원가입 페이지
router.get('/join', (req, res) => {
    res.render('join', {title : '회원가입'});
});

// 아이디 찾기 페이지


// 비밀번호 찾기 페이지

module.exports = router;