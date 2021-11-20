const { response } = require("express");
const { getMunicipios, getColonias } = require("../helpers/municipios");




const getMunicipilities = async(req, res = response) => {


    try {

        const municipalities = getMunicipios();

      
        res.status(200).json({
            status: true,
            municipalities
        })


    } catch( err ) {
        console.log(error);
        res.status(500).json({
            status: false,
            message: 'Hable con el administrador'
        })
    }
}




const getColoniesByMunicipaly = async(req, res = response) => {


    try {

        const colonies = getColonias( req.params.municipality );

      
        res.status(200).json({
            status: true,
            colonies
        })


    } catch( err ) {
        console.log(error);
        res.status(500).json({
            status: false,
            message: 'Hable con el administrador'
        })
    }
}


module.exports = {
    getMunicipilities,
    getColoniesByMunicipaly
}