

const { response } = require('express');
const fs = require('fs');
const path = require('path')
const { v4: uuidv4 } = require('uuid');

const User = require('../models/user');
const Report = require('../models/report');
const Institute = require('../models/institute');
const New = require('../models/new');
const Tip = require('../models/tip');


const uploadfile = async( req, res = response ) => {

    const coleccion = req.params.coleccion;
    const id = req.params.id

    const coleccionesValidas = ['users', 'reports', 'institutes', 'news', 'tips'];

    if ( !coleccionesValidas.includes( coleccion ) ){
        return res.status(400).json({
            status: false,
            message: 'No es una coleccción válida'
        })
    }

    // Validar que exista un archivo 
    if( !req.files || Object.keys(req.files).length === 0 ){
        return res.status(400).json({
            status: false,
            message: 'No hay ningún archivo'
        }) 
    }


    // Procesar la imagen
    const file = req.files.image;

    const nombreCortado = file.name.split('.'); //nombre.archivo.jpg
    const extensionArchivo = nombreCortado[ nombreCortado.length - 1 ];

    const extensionesValidas = ['png', 'jpg', 'jpeg', 'gif'];
    if( !extensionesValidas.includes( extensionArchivo ) ){
        return res.status(400).json({
            status: true,
            message: 'No es una extensión permitida'
        }) 
    }

    // Generar el nombre del Archivo
    const nombreArchivo = `${ uuidv4() }.${ extensionArchivo }`;

    // Path para guardar la imagen
    const path = `./uploads/${coleccion}/${nombreArchivo}`;

    

    //***** Actualizar la imagen */
    const model = coleccion === 'users' ? User : coleccion === 'reports' ? Report : coleccion === 'institutes' ? Institute : coleccion === 'news' ? New : coleccion === 'tips' ? Tip : null   


    const currentColleccion = await model.findById( id );      
    
    if ( !currentColleccion ){
        return res.status(404).json({
            status: false,
            message: `No existe un registro con el ID ${ id }`
        });
    }

    
    const currentPath = `./uploads/${coleccion}/${currentColleccion.image}`;
    borrarImagen( currentPath )

    currentColleccion.image = nombreArchivo;
    await currentColleccion.save()
 
    // Mover el archivo a al path
    file.mv( path, (err) => {

        if (err) {
            console.log(err);
            return res.status(500).json({
                status: false,
                message: 'Error al mover la imagen'
            })
        }    

        res.json({
            status: true,
            message: 'Imagen subida con éxito',
            nombreFoto: nombreArchivo
        })

    })


}




const borrarImagen = ( path ) => {

    if ( fs.existsSync( path ) ) {
        fs.unlinkSync( path );
    }

}



const obtenerImagen = (req, res) => {
    const coleccion = req.params.coleccion;
    const image = req.params.image;

    const pathImg = path.join( __dirname, `../uploads/${ coleccion }/${ image }` );

    if ( fs.existsSync (pathImg) ){
        res.sendFile( pathImg )
    } else {
        const pathImg = path.join( __dirname, `../assets/no-image.jpg` );
        res.sendFile( pathImg );
    }

}

module.exports = {
    uploadfile,
    obtenerImagen
}
