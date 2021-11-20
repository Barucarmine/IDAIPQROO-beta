const { Router } = require('express');
const { check } = require('express-validator');
const { getReportsNotAssigned, create, assign, updateMyReport, joinUser, getAllReportsNotAssigned, getReportByIdNotAssigned, estadisticasCategoriesByMunicipality } = require('../controllers/report.controllers');
const { validarCampos } = require('../middlewares/validar-campos.middleware');
const { validarJWT } = require('../middlewares/validar-jwt.middleware');


const router = Router();


router.get('/notassigned', validarJWT ,getReportsNotAssigned);

router.get('/allnotassigned', getAllReportsNotAssigned);

router.get('/estadisticas/:municipioName', estadisticasCategoriesByMunicipality );


router.get('/notassignedById/:id', getReportByIdNotAssigned);

router.get('/joinuser/:serviceId', validarJWT, joinUser );



router.post('/create', [
    validarJWT,
    check('title', 'El title es requerido.').not().isEmpty(),
    check('category', 'El category es requerido.').not().isEmpty(),
    check('description', 'El description es requerido.').not().isEmpty(),
    validarCampos,
], create );

router.get('/assign/:reportId/:instituteId', assign );

router.put('/:reportId', validarJWT, updateMyReport );




module.exports = router;