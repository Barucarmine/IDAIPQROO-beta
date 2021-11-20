const { response } = require("express")
const Tip = require('../models/tip');


const getAll = async(req, res = response) => {


    try {

       const tips = await Tip.find({});

        return res.status(200).json({
            status: true,
            tips
        })

    } catch( error ) {
        console.log(error);
        res.status(500).json({
            status: false,
            message: 'Hable con el administrador'
        })
    }
}


const create = async(req, res = response) => {


    try {

       const tip = new Tip(req.body);
       await tip.save();

        return res.status(200).json({
            status: true,
            message: 'Tip creado con éxito',
            tip
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
    getAll,
    create
}