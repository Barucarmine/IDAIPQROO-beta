const { response } = require("express")
const Service = require('../models/service');


const getServices = async(req, res = response) => {


    try {

       const termino = req.params.termino;

       const regExp = new RegExp( termino, 'i' );

       let services = [];

       const servicesdb = await Service.find({})
                .populate('report')
                .populate('institute')
                .populate({
                    path: 'report',
                    populate: 'user'
                })
                .sort({ contributions: -1 })
        

        servicesdb.forEach( s => {
            if(s.report.title.match(regExp)) {
                services.push(s);
            }
        })

        return res.status(200).json({
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

module.exports = {
    getServices
}