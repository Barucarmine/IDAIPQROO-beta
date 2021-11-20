const { response } = require("express")
const Service = require('../models/service');







const getByStatus = async(req, res = response) => {


    try {

        const status = req.params.status;
        const category = req.params.category;

        const servicesdb = await Service.find({status:status.toUpperCase() })
        .populate('report')
        .populate('institute')
        .populate({
            path: 'report',
            populate: 'user'
        })
        .sort({ contributions: -1 })

        let services = [];

        servicesdb.forEach( service => {
            if ( service['report'].category == category ){
                services.push( service );
            }
        })



        res.status(200).json({
            status: true,
            services
        })


    } catch( error ) {
        console.log(error);
        res.status(500).json({
            status: false,
            message: 'Hable con el administrador'
        })
    }
}


const getMyServicesByStatus = async(req, res = response) => {


    try {

        const id = req.id;
        const status = req.params.status;
        const category = req.params.category;

        const servicesdb = await Service.find({status:status.toUpperCase() })
        .populate('report')
        .populate('institute')
        .populate({
            path: 'report',
            populate: 'user'
        })
        .sort({ contributions: -1 })

        let services = [];

        servicesdb.forEach( service => {
            if ( service['report'].category == category && service['report'].user._id == id ){
                services.push( service );
            }
        })

        res.status(200).json({
            status: true,
            services
        })


    } catch( error ) {
        console.log(error);
        res.status(500).json({
            status: false,
            message: 'Hable con el administrador'
        })
    }
}



const getByInstituteAndStatus = async(req, res = response) => {


    try {

        const instituteId = req.params.instituteId;
        const status = req.params.status;

        const services = await Service.find({status:status.toUpperCase(), institute: instituteId })
        .populate('report')
        .populate('institute')
        .populate({
            path: 'report',
            populate: 'user'
        })
        .sort({ contributions: -1 })

        

        res.status(200).json({
            status: true,
            services
        })


    } catch( error ) {
        console.log(error);
        res.status(500).json({
            status: false,
            message: 'Hable con el administrador'
        })
    }
}




const getById = async(req, res = response) => {


    try {

        const id = req.params.id;

        const service = await Service.findById( id )
        .populate('report')
        .populate('institute')
        .populate({
            path: 'report',
            populate: 'user'
        })


        res.status(200).json({
            status: true,
            service
        })


    } catch( error ) {
        console.log(error);
        res.status(500).json({
            status: false,
            message: 'Hable con el administrador'
        })
    }
}




const updateService = async(req, res = response ) => {
    

    try {

        const id = req.params.id

        const exist = await Service.findById(id);

        if ( !exist ) {
            return res.status(404).json({
                status: false,
                message: `No existe un reporte con el id ${ id }`,
            })
        }

        const data = {
            ...req.body
        }

        const service = await Service.findByIdAndUpdate( id, data, { new: true })

        res.status(200).json({
            status: true,
            message: 'Reporte actualizado con éxito.',
            service
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
    getByStatus,
    getByInstituteAndStatus,
    getMyServicesByStatus,
    getById,
    updateService
}