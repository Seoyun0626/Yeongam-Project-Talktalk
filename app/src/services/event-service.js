var db = require('../utils/db');
// var s_db = require('../utils/s_db');
var bkfd2Password = require('pbkdf2-password');
var hasher = bkfd2Password();
const url = require('url');
// const { uuid } = require('uuidv4');
const { v4: uuidv4 } = require('uuid');
var utils = require('../utils/utils');
var fs = require('fs');