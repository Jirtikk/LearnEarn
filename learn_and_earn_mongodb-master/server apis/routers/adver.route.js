const router = require('express').Router();
const adverController = require('../controller/adver.controller');

router.post("/getall",adverController.getalldata);

module.exports = router;
