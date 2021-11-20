
const { Schema, model } = require('mongoose');

const ServiceSchema = Schema({

    report: {
        type: Schema.Types.ObjectId,
        ref: 'Report',
        required: true
    },
    institute: {
        type: Schema.Types.ObjectId,
        ref: 'Institute',
        required: true
    },
    observations: {
        type: String
    },
     /* FINALIZED, CANCELLED, PROCESS, PENDING */
    status: {
        type: String,
        required: true,
        default: 'PROCESS'
    }, 
    qualification: {
        points: {
            type: Number,
        },
        commet: {
            type: String,
        }
    },
    contributions: {
        type: Number,
        default: 1
    }


}, {
    timestamps: true
});

ServiceSchema.method('toJSON', function() {
    const { __v, ...object } = this.toObject();
    return object;
})



module.exports = model('Service', ServiceSchema );