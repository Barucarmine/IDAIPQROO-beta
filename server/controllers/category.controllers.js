const { response } = require("express")
const Category = require('../models/category-report');



const create = async(req, res = response) => {


    try {

        const category = new Category(req.body)
        await category.save();


        res.status(201).json({
            status: true,
            message: 'Categoria creada con éxito.',
            category
        })


    } catch( err ) {
        console.log(error);
        res.status(500).json({
            status: false,
            message: 'Hable con el administrador'
        })
    }
}



const getCategories = async(req, res = response) => {


    try {

        const categoriesdb = await Category.find({});

        let categories = [];

        categoriesdb.forEach( c => {
            categories.push(c.title)
        })

        res.status(200).json({
            status: true,
            categories
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
    getCategories,
    create
}