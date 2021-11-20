const { Router } = require('express');
const { getMunicipilities, getColoniesByMunicipaly } = require('../controllers/municipality.controller');


const router = Router();


router.get('/all', getMunicipilities);
router.get('/colonies/:municipality', getColoniesByMunicipaly );



module.exports = router;