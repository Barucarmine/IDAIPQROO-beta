const { Router } = require('express');
const { check } = require('express-validator');
const { register, login, renewJWT } = require('../controllers/auth.controllers');
const { validarCampos } = require('../middlewares/validar-campos.middleware');
const { validarJWT } = require('../middlewares/validar-jwt.middleware');


const router = Router();


router.post('/login', [
    check('email', 'El email es requerido.').not().isEmpty(),
    check('password', 'El password es requerido.').not().isEmpty(),
    validarCampos
], login);
router.post('/register', [
    check('email', 'El email es requerido.').not().isEmpty(),
    check('name', 'El name es requerido.').not().isEmpty(),
    check('password', 'El password es requerido.').not().isEmpty(),
    validarCampos
], register);
router.get('/renew', validarJWT, renewJWT);



module.exports = router;