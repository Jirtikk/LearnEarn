const router = require('express').Router();
const adverController = require('../controller/started.controller');

router.post("/registerstarted",adverController.registerstarted);
router.post("/getstartedlength",adverController.getstartedlength);
router.post("/getstartedunique",adverController.getstartedunique);
router.post("/addtovlist",adverController.addtovlist);
router.post("/addtoqlist",adverController.addtoqlist);
router.post("/getstartedbynum",adverController.getstartedbynum);

module.exports = router;
