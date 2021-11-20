const { userConnected, userDisconnected, getAllUsers, saveMessage } = require("../controllers/sockets.controllers");
const { comprobarJWT } = require("../helpers/jwt.helper");


class Sockets {

    constructor( io ) {
        this.io = io;

        this.socketsEvents();
    }


    socketsEvents() {
        
        // On connection
        this.io.on('connection', async ( socket ) => {
        
            // Validar que el token sea valido
            const [ valid, id ] = comprobarJWT( socket.handshake.query['accessToken'] )

            if ( !valid ) {
                console.log('Socket no identificado');
                return socket.disconnect();
            }
            // Conectar y actualzar en la db
            // console.log('Cliente conectado', id)
            console.log('Cliente conectado')
            await userConnected( id );

            // Emitir lista de usuarios a TODOS
            // this.io.emit('users-list', await getAllUsers() );

            
            // Unir al usuario a una sala
            socket.join( id );

            // Escuchar del cliente el personal-message
            socket.on('personal-message', async (payload) => {
                // console.log(payload)

                // Guardar message en la base de datos
                await saveMessage( payload );

                // Emitir el mensaje 
                this.io.to( payload.to ).emit('personal-message', payload)
            })


            // Desconectar y actualzar en la db
            socket.on('disconnect', async () => {
                console.log('Cliente desconectado');
                await userDisconnected( id );
                // this.io.emit('users-list', await getAllUsers() );
            })
        
        })

    }


}


module.exports = Sockets;