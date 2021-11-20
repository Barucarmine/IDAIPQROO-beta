const { Router } = require('express');
const { getByStatus, getMyServicesByStatus, getByInstituteAndStatus, getById, updateService } = require('../controllers/service.controller');
const { validarJWT } = require('../middlewares/validar-jwt.middleware');


const router = Router();


router.get('/all/:status/:category', getByStatus);

router.get('/id/:id', getById);

router.put('/id/:id', updateService);

router.get('/user/:status/:category', validarJWT, getMyServicesByStatus);

router.get('/institute/:status/:instituteId', getByInstituteAndStatus);



module.exports = router;