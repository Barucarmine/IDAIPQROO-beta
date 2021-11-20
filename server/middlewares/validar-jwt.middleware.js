const jwt = require('jsonwebtoken');

const validarJWT = (req, res, next) => {

    if (!req.headers['authorization']) {
        return res.status(401).json({
            status: false,
            message: 'No hay accessToken en la petición.'
        })
    }

    try {
        const authHeader = req.headers['authorization'];
        const bearerToken = authHeader.split(' ');
        const token = bearerToken[1];

        const { id } = jwt.verify(token, process.env.JWT_SEED)

        req.id = id;

        next();

    } catch (error) {
        return res.status(401).json({
            status: false,
            message: 'accessToken no válido.'
        })
    }



}




module.exports = {
    validarJWT,
}