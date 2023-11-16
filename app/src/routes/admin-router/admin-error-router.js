const express = require('express');
const router = express.Router();

router.use((err, req, res, next) => {
    if (err.status === 403) {
        // handle 403 error
        res.status(403).send('Forbidden');
    } else {    
        next(err);
    }
});

module.exports = router;
