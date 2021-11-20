const { response } = require("express")
const Event = require('../models/event');


const getEventsVisibles = async(req, res = response) => {


    try {

       const events = await Event.find({show: true})
                .sort({ date: -1 })
    
        return res.status(200).json({
            status: true,
            events
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

        const event = new Event( req.body );
        await event.save();
    
        return res.status(201).json({
            status: true,
            event
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
    getEventsVisibles,
    create
}