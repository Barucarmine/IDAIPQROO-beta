
const { Schema, model } = require('mongoose');

const ReportSchema = Schema({

    user: {
        type: Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    title: {
        type: String,
        required: true
    },
    category: {
        type: String,
        required: true
    },
    description: {
        type: String,
        required: true
    },
    location: {
        lat: {},
        lng: {},
    },
    municipality: {
        type: String,
    },
    colony: {
        type: String,
    },
    image: {
        type: String,
    }, 
    anonymous: {
        type: Boolean,
        default: false
    },
    /* Debe de estar aceptado por la idaipqroo para ser visible */
    assigned: {
        type: Boolean,
        default: false
    },


}, {
    timestamps: true
});

ReportSchema.method('toJSON', function() {
    const { __v, ...object } = this.toObject();
    return object;
})



module.exports = model('Report', ReportSchema );