const { Router } = require('express');
const { getServices } = require('../controllers/search.controller');


const router = Router();


router.get('/:termino', getServices);


module.exports = router;