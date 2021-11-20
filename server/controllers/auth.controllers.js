


const { response } = require('express');
const bcrypt = require('bcrypt');
const User = require('../models/user');
const { generarJWT } = require('../helpers/jwt.helper');




const register = async(req, res = response ) => {

    const { email, password } = req.body;

    try {

        const doesExist = await User.findOne({ email });

        if (doesExist) {
            return res.status(400).json({
                status: false,
                message: `Ya existe un usuario con el correo electrónico ${ email }.`
            })
        }

        const user = new User(req.body);
        const salt = bcrypt.genSaltSync();
        user.password = bcrypt.hashSync(password, salt);

        const savedUser = await user.save();
        const accessToken = await generarJWT(savedUser.id);

        res.status(201).json({
            status: true,
            message: `Usuario creado con éxito`,
            user: savedUser,
            accessToken
        })


    } catch( err ) {
        console.log(error);
        res.status(500).json({
            status: false,
            message: 'Hable con el administrador'
        })
    }

}


const login = async(req, res = response) => {

    const { email, password } = req.body;

    try {

        const user = await User.findOne({ email })


        if (!user) {
            return res.status(404).json({
                status: false,
                message: 'Correo electrónico inválido.'
            })
        }


        const validarPassword = bcrypt.compareSync( password, user.password)


        if (!validarPassword) {
            return res.status(404).json({
                status: false,
                message: 'Contraseña inválida.'
            });
        }

        const accessToken = await generarJWT(user.id);


        res.status(200).json({
            status: true,
            user,
            accessToken
        });


    } catch (error) {
        console.log(error);
        res.status(500).json({
            status: false,
            message: 'Hable con el administrador'
        })
    }
    
}




const renewJWT = async(req, res = response) => {

    const id = req.id
    const accessToken = await generarJWT(id)
    const user = await User.findById(id)

    res.json({
        status: true,
        user,
        accessToken
    })
}


module.exports = {
    register,
    login,
    renewJWT
}
