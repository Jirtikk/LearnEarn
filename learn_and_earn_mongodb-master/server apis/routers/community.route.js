const router = require('express').Router();
const adverController = require('../controller/community.service');

router.post("/registercommunity",adverController.registercommunity);
router.post("/getallcommunity",adverController.getallcommunity);

module.exports = router;
