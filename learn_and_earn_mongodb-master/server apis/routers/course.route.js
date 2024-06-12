const router = require('express').Router();
const courseController = require('../controller/course.controller');

router.post("/getallcourse",courseController.getalldata);
router.post("/registercourse",courseController.registercourse);
router.post("/deletecourse",courseController.deletecourse);
router.post("/getcoursebyid",courseController.getcoursebyid);

module.exports = router;
