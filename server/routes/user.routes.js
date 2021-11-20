const { Router } = require('express');
const { getUserAdminRole, getAllUserRole } = require('../controllers/user.controllers');


const router = Router();


router.get('/admin', getUserAdminRole);

router.get('/user', getAllUserRole);



module.exports = router;