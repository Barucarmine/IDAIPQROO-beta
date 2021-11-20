const { Router } = require('express');
const { getChat } = require('../controllers/message.controllers');
const { validarJWT } = require('../middlewares/validar-jwt.middleware');


const router = Router();

router.get('/:from', validarJWT, getChat );


module.exports = router;