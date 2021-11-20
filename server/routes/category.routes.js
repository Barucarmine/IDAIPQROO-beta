const { Router } = require('express');
const { check } = require('express-validator');
const { create, getCategories } = require('../controllers/category.controllers');
const { validarCampos } = require('../middlewares/validar-campos.middleware');


const router = Router();


router.get('/all', getCategories);
router.post('/create', [
    check('title', 'El title es requerido.').not().isEmpty(),
    validarCampos
], create );



module.exports = router;