const path = require("path");
var express = require("express");
var fs = require("fs");
var router = express.Router();
var event_controller = require("../../controllers/common-controller/event-controller");
var code_controller = require("../../controllers/common-controller/codeData-controller");

const ensureAuth = require("../../utils/middleware/ensureAuth");
const asyncHandler = require("../../utils/middleware/asyncHandler");