const router = require('express').Router();
const interviewController = require('../controller/interview.controller');

router.post("/interviewmodelreg",interviewController.interviewmodelreg);
router.post("/getallinterview",interviewController.getallinterview);
router.post("/getoneinterviewadded",interviewController.getoneinterviewadded);
router.post("/getoneinterviewapplied",interviewController.getoneinterviewapplied);

module.exports = router;
