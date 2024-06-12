const router = require('express').Router();
const userController = require('../controller/user.controller');

router.post("/register",userController.register);
router.post("/login",userController.login);
router.post("/getoneuserdata",userController.getoneuserdata);
router.post("/alluser",userController.alluser);
router.post("/deleteuser",userController.deleteuser);

module.exports = router;
