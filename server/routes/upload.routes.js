const { Router } = require('express');
const { obtenerImagen, uploadfile } = require('../controllers/upload.controllers');


const router = Router();


router.get('/:coleccion/:image', obtenerImagen);
router.put('/:coleccion/:id', uploadfile);



module.exports = router;