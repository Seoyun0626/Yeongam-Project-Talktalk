
// const jwt = require('jsonwebtoken');

// // Verify token to Routes
// export const verifyToken = (req, res, next) => {
//     let token = req.header('xxx-token');
//     if (!token) {
//         return res.status(401).json({
//             resp: false,
//             message: '접근 불가'
//         });
//     }
//     try {
//         const payload = jwt.verify(token, process.env.TOKEN_SECRET || 'Yeongam Yeongam');
//         req.idPerson = payload.idPerson;
//         next();
//     }
//     catch (err) {
//         return res.status(500).json({
//             resp: false,
//             message: err
//         });
//     }
// };
// // Verify token to Socket 
// // export const verifyTokenSocket = (token) => {
// //     try {
// //         const payload = jwt.verify(token, process.env.TOKEN_SECRET || 'Frave_Social');
// //         return [true, payload.idPerson];
// //     }
// //     catch (err) {
// //         return [false, ''];
// //     }
// // };