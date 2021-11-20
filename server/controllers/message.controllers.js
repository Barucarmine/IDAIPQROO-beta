
const { response } = require('express');
const Message = require('../models/message');

const getChat = async( req, res = response) => {

    const id = req.id;
    const messagesFrom = req.params.from;

    // Obtener los ultimos 30 mensajes
    const last30 = await Message.find({
        $or: [
            {
                from: messagesFrom,
                to: id,
            },
            {
                from: id,
                to: messagesFrom,
            }
        ]
    }).sort({ createdAt: 'desc' })
    .limit(30)

    try {
        

        res.status(200).json({
            status: true,
            messages: last30
        })

    } catch(error) {
        console.log(error);
        res.status(500).json({
            status: false,
            message: 'Hable con el administrador.'
        })
    }

}



module.exports = {
    getChat
}