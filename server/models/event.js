
const { Schema, model } = require('mongoose');

const EventSchema = Schema({

    title: {
        type: String,
        required: true
    },
    subtitle: {
        type: String,
    },
    description: {
        type: String,
        required: true
    },
    municipality: {
        type: String,
    },
    direction: {
        type: String,
    },
    image: {
        type: String,
    },
    date: {
        type: String,
        required: true
    },
    hour: {
            type: String,
            required: true
    },
    show: {
        type: Boolean,
        default: true
    }


});

EventSchema.method('toJSON', function() {
    const { __v, ...object } = this.toObject();
    return object;
})



module.exports = model('Event', EventSchema );