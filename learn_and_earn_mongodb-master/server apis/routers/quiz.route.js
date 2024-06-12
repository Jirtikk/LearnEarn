const router = require('express').Router();
const quizController = require('../controller/quiz.controller');

router.post("/registerquiz",quizController.registerquiz);
router.post("/getonequiz",quizController.getonequiz);
router.post("/updateusers",quizController.updateusers);
router.post("/getonequizdata",quizController.getonequizdata);
router.post("/getcer",quizController.getcer);

module.exports = router;
