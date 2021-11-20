const { response } = require("express")
const User = require('../models/user');


const getUserAdminRole = async(req, res = response) => {


    try {

       const user = await User.findOne({role: 'ADMIN_ROLE'})

        return res.status(200).json({
            status: true,
            user
        })

    } catch( error ) {
        console.log(error);
        res.status(500).json({
            status: false,
            message: 'Hable con el administrador'
        })
    }
}



const getAllUserRole = async(req, res = response) => {


    try {

       const users = await User.find({role: 'USER_ROLE'})

        return res.status(200).json({
            status: true,
            users
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
    getUserAdminRole,
    getAllUserRole
}