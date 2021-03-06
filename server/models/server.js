const express = require('express');
const http = require('http');
const socketio = require('socket.io');
const path = require('path');
const cors = require('cors');
const { dbConnection } = require('../database/config');
const Sockets = require('./sockets');
const fileUpload = require('express-fileupload');



class Server {

    constructor() {
        this.app = express();;
        this.port = process.env.PORT;

        // Conectar a db
        dbConnection();

        // Http server
        this.server = http.createServer(this.app);

        // Configuraciones de sockets
        this.io = socketio(this.server, { /* configuraciones */ });

    }


    middlewares() {
        this.app.use(express.static(path.resolve(__dirname, '../public')));

        this.app.use(cors());
        this.app.use(express.json());
        this.app.use(fileUpload());

        this.app.use('/api/auth', require('../routes/auth.routes'));
        this.app.use('/api/message', require('../routes/message.routes'));
        this.app.use('/api/category', require('../routes/category.routes'));
        this.app.use('/api/report', require('../routes/report.routes'));
        this.app.use('/api/institute', require('../routes/institute.routes'));
        this.app.use('/api/municipality', require('../routes/municipality.routes'));
        this.app.use('/api/service', require('../routes/service.routes'));
        this.app.use('/api/search', require('../routes/search.routes'));
        this.app.use('/api/upload', require('../routes/upload.routes'));
        this.app.use('/api/new', require('../routes/new.routes'));
        this.app.use('/api/event', require('../routes/events.routes'));
        this.app.use('/api/user', require('../routes/user.routes'));
        this.app.use('/api/tip', require('../routes/tip.routes'));

    }



    configSockets() {
        new Sockets(this.io);
    }

    execute() {

        // Inicializar Middlewares
        this.middlewares();

        // Inicializar Sockets
        this.configSockets();

        // Inicializar Server
        this.server.listen(this.port, () => {
            console.log('Servidor corriendo en puerto:', this.port);
        })
    }


}


module.exports = Server;