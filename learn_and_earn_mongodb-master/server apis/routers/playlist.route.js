const router = require('express').Router();
const playlistController = require('../controller/playlist.controller');

router.post("/getcourseplaylist",playlistController.getcourseplaylist);
router.post("/registerplaylist",playlistController.registerplaylist);

module.exports = router;
