const { Router } = require('express');
const { check } = require('express-validator');
const { getNews, create } = require('../controllers/news.controller');
const { validarCampos } = require('../middlewares/validar-campos.middleware');


const router = Router();


router.get('/all', getNews);
router.post('/create', [
    check('title', 'El title es requerido.').not().isEmpty(),
    check('content', 'El title es requerido.').not().isEmpty(),
    validarCampos
], create );



module.exports = router;