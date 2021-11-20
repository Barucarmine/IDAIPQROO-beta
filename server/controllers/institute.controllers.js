

const { response } = require("express");
const Institute = require('../models/institute');
const Service = require('../models/service');



const create = async(req, res = response) => {


    try {

       
        const institute = new Institute(req.body)
        await institute.save();  


        res.status(201).json({
            status: true,
            message: 'Instituto creado con éxito.',
            institute
        })


    } catch( err ) {
        console.log(error);
        res.status(500).json({
            status: false,
            message: 'Hable con el administrador'
        })
    }
}


const getInstitutesByMunicipality = async(req, res = response) => {


    try {

        const municipality = req.params.municipalityId;

        const institutes = await Institute.find({municipality});

        res.status(200).json({
            status: true,
            institutes
        })


    } catch( err ) {
        console.log(error);
        res.status(500).json({
            status: false,
            message: 'Hable con el administrador'
        })
    }
}




const getAll = async(req, res = response) => {


    try {

        const institutes = await Institute.find({});

        res.status(200).json({
            status: true,
            institutes
        })


    } catch( err ) {
        console.log(error);
        res.status(500).json({
            status: false,
            message: 'Hable con el administrador'
        })
    }
}




const getById = async(req, res = response) => {


    try {

        const instituteId = req.params.instituteId;

        const institute = await Institute.findById( instituteId );

        if ( !institute ){
            res.status(404).json({
                status: false,
                message: `No existe una institución con el ID ${ instituteId }` 
            })
        }
        
        const [ total, proceso, finalizados, cancelados ] = await Promise.all([
            Service.count({ institute: instituteId }),
            Service.count({ status: 'PROCESS', institute: instituteId }),
            Service.count({ status: 'FINALIZED', institute: instituteId }),
            Service.count({ status: 'CANCELLED', institute: instituteId })
        ])

        

        res.status(200).json({
            status: true,
            total,
            institute,
            proceso,
            finalizados,
            cancelados
        })


    } catch( error ) {
        console.log(error);
        res.status(500).json({
            status: false,
            message: 'Hable con el administrador'
        })
    }

}


module.exports = {
    create,
    getInstitutesByMunicipality,
    getById,
    getAll
}