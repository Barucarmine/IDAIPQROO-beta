const { Router } = require('express');
const { check } = require('express-validator');
const { getInstitutesByMunicipality, create, getById, getAllEstadisticasByStatus, getAll } = require('../controllers/institute.controllers');
const { validarCampos } = require('../middlewares/validar-campos.middleware');


const router = Router();



router.get('/all', getAll);

router.get('/all/:municipalityId', getInstitutesByMunicipality);

router.get('/id/:instituteId', getById);

router.post('/create', [
    check('manager', 'El manager es requerido.').not().isEmpty(),
    check('name', 'El name es requerido.').not().isEmpty(),
    check('description', 'El description es requerido.').not().isEmpty(),
    check('municipality', 'El municipality es requerido.').not().isEmpty(),
    validarCampos
], create );


module.exports = router;