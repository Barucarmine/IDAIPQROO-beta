const { Router } = require('express');
const { check } = require('express-validator');
const { create, getAll} = require('../controllers/tip.controller');
const { validarCampos } = require('../middlewares/validar-campos.middleware');


const router = Router();


router.get('/all', getAll);
router.post('/create', [
    check('text', 'El title es requerido.').not().isEmpty(),
    check('text', 'El max 280 caracteres.').isLength({min:0, max:280}),
    validarCampos
], create );



module.exports = router;