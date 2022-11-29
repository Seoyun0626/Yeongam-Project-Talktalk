var createError = require('http-errors');
var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var logger = require('morgan');
var db = require('./db');

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');

// 익스프레스 객체 선언
var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views')); // 경로
app.set('view engine', 'ejs'); // 템플릿 엔진 : ejs

db.connect(function(err) {
  if (err) {
    console.log('Unable to connet to MySQL.');
    process.exit(1);
  }
})



app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

// 라우트(url 뒷부분) 설정
app.use('/', indexRouter);
app.use('/users', usersRouter);
app.use('/member', require('./routes/member'));

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
