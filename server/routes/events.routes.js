const { Router } = require('express');
const { check } = require('express-validator');
const { getEventsVisibles, create } = require('../controllers/event.controllers');
const { validarCampos } = require('../middlewares/validar-campos.middleware');


const router = Router();


router.get('/all', getEventsVisibles);
router.post('/create', [
    check('title', 'El title es requerido.').not().isEmpty(),
    check('description', 'El description es requerido.').not().isEmpty(),
    check('municipality', 'El municipality es requerido.').not().isEmpty(),
    check('direction', 'El direction es requerido.').not().isEmpty(),
    check('date', 'El date es requerido.').not().isEmpty(),
    check('hour', 'El hour es requerido.').not().isEmpty(),
    validarCampos
], create );



module.exports = router;

