const { response } = require("express")
const New = require('../models/new');


const getNews = async(req, res = response) => {


    try {

       const news = await New.find({})
                .sort({ createdAt: -1 })
    
        return res.status(200).json({
            status: true,
            news
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

        const newdb = new New( req.body );
        await newdb.save();
    
        return res.status(201).json({
            status: true,
            new: newdb
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
    getNews,
    create
}