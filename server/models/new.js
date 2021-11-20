const { Schema, model } = require('mongoose');

/* COmentarios a la app */
const NewSchema = Schema({

    image: {
        type: String,
    },
    text: {
        type: String,
        required: true
    },
    descripcion: {
        type: String,
        required: true
    },
    show: {
        type: Boolean,
        default: true
    }


}, {
    timestamps: true
});

NewSchema.method('toJSON', function() {
    const { __v, ...object } = this.toObject();
    return object;
})



module.exports = model('Novedad', NewSchema);