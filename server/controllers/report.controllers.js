const { response } = require("express")
const Report = require('../models/report');
const Service = require('../models/service');
const Institute = require('../models/institute');
const Contribution = require('../models/contribution');


const create = async(req, res = response) => {

    const id = req.id;

    try {

        const data = {
            ...req.body,
            user: id
        }

        const newReport = new Report(data)
        await newReport.save();

        // const report = await Report.findById(report.id);
        newReport.user = undefined;


        res.status(201).json({
            status: true,
            message: 'Reporte creado con éxito.',
            report: newReport
        })


    } catch( err ) {
        console.log(error);
        res.status(500).json({
            status: false,
            message: 'Hable con el administrador'
        })
    }
}


const getAllReportsNotAssigned = async(req, res = response) => {


    try {

        const reports = await Report.find({assigned: false})
                .populate('user');

        res.status(200).json({
            status: true,
            reports
        })


    } catch( err ) {
        console.log(error);
        res.status(500).json({
            status: false,
            message: 'Hable con el administrador'
        })
    }
}


const getReportsNotAssigned = async(req, res = response) => {


    try {

        const id = req.id;

        const reports = await Report.find({user: id, assigned: false})
                .populate('user');

        res.status(200).json({
            status: true,
            reports
        })


    } catch( err ) {
        console.log(error);
        res.status(500).json({
            status: false,
            message: 'Hable con el administrador'
        })
    }
}


const getReportByIdNotAssigned = async(req, res = response) => {


    try {

        const id = req.params.id;

        const report = await Report.findById( id )
                .populate('user');

        res.status(200).json({
            status: true,
            report
        })


    } catch( err ) {
        console.log(error);
        res.status(500).json({
            status: false,
            message: 'Hable con el administrador'
        })
    }
}




const assign = async(req, res = response) => {


    try {

        const reportId = req.params.reportId;
        const instituteId = req.params.instituteId;

        const [report, institute] = await Promise.all([
            Report.findById( reportId ),
            Institute.findById( instituteId ),
        ])


        if( !report ) {
            return res.status(404).json({
                status: false,
                message: `No existe un reporte con el id ${ reportId }`,
            })
        }


        if( !institute ) {
            return res.status(404).json({
                status: false,
                message: `No existe un institute con el id ${ instituteId }`,
            })
        }

        report.assigned = true;
        await report.save();

        const data = {
            report,
            institute
        }

        const service = new Service(data);
        service.save();

        res.status(201).json({
            status: true,
            message: 'Servicio creado con éxito',
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


const updateMyReport = async(req, res = response ) => {
    

    try {

        const reportId = req.params.reportId

        const exist = await Report.findById(reportId);

        if ( !exist ) {
            return res.status(404).json({
                status: false,
                message: `No existe un reporte con el id ${ reportId }`,
            })
        }

        if ( exist.user != req.id ) {
            return res.status(400).json({
                status: false,
                message: `Este reporte no pertenece al usuario`,
            })
        }

        const data = {
            ...req.body,
            image: undefined
        }

        const report = await Report.findByIdAndUpdate( reportId, data, { new: true })
            .populate('user');

        res.status(200).json({
            status: true,
            report
        })

    } catch( error ) {
        console.log(error);
        res.status(500).json({
            status: false,
            message: 'Hable con el administrador'
        })
    }

}


// contributions
const joinUser = async(req, res = response) => {

    try {

        const user = req.id;
        const serviceId = req.params.serviceId;

        const service = await Service.findById(serviceId)
        .populate('institute')
        .populate('report')
        .populate({
            path: 'report',
            populate: 'user'
        });

        if( !service ) {
            return res.status(404).json({
                status: false,
                message: `No existe un service con el id ${ serviceId }`,
            })
        }

        if( service.report.user == user ) {
            return res.status(400).json({
                status: false,
                message: `No te puedes unir a un reporte creado por ti.`,
            })
        }


        const existJoin = await Contribution.findOne({user, service});

        if( existJoin ) {
            return res.status(400).json({
                status: false,
                message: `Ya estás unido.`,
            })
        }

        const contribution = new Contribution({user, service});
        await contribution.save();

        service.contributions = service.contributions + 1;
        await service.save();

        res.status(201).json({
            status: true,
            message: 'Te has unido con éxito.',
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



const estadisticasCategoriesByMunicipality = async(req, res = response) => {

    try {

        const municipioName = req.params.municipioName;
        console.log(municipioName)

        const [ total, vialidad, salud_publica, buena_vecindad, atencion_ciudadana, otro ] = await Promise.all([
            Report.count({ municipality: municipioName, assigned: true }),
            Report.count({ municipality: municipioName, assigned: true, category: 'Vialidad'}),
            Report.count({ municipality: municipioName, assigned: true, category: 'Salud Pública'}),
            Report.count({ municipality: municipioName, assigned: true, category: 'Buena vecindad'}),
            Report.count({ municipality: municipioName, assigned: true, category: 'Atención ciudadana'}),
            Report.count({ municipality: municipioName, assigned: true, category: 'Otro'}),
        ])

        res.status(201).json({
            status: true,
            total,
            vialidad,
            salud_publica,
            buena_vecindad,
            atencion_ciudadana,
            otro
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
    getReportsNotAssigned,
    create,
    assign,
    updateMyReport,
    joinUser,
    getAllReportsNotAssigned,
    getReportByIdNotAssigned,
    estadisticasCategoriesByMunicipality
}