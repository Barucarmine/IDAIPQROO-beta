
const { Schema, model } = require('mongoose');

const InstituteSchema = Schema({

    manager: {
        type: String,
        required: true
    },
    name: {
        type: String,
        required: true
    },
    siglas: {
        type: String
    },
    description: {
        type: String,
        required: true
    },
    municipality: {
        type: String,
    },
    adress: {
        type: String,
    },
    image: {
        type: String,
    }


});

InstituteSchema.method('toJSON', function() {
    const { __v, ...object } = this.toObject();
    return object;
})



module.exports = model('Institute', InstituteSchema );