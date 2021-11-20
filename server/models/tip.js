const { Schema, model } = require('mongoose');

const TipSchema = Schema({

    text: {
        type: String,
    },
    descripcion: {
        type: String
    },
    image: {
        type: String
    },
    show: {
        type: Boolean,
        default: true
    }

}, {
    timestamps: true
});

TipSchema.method('toJSON', function() {
    const { __v, ...object } = this.toObject();
    return object;
})



module.exports = model('Tip', TipSchema);