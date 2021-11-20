
const { Schema, model } = require('mongoose');

const CategoryReportSchema = Schema({

    title: {
        type: String,
        required: true
    },

});

CategoryReportSchema.method('toJSON', function() {
    const { __v, _id, ...object } = this.toObject();
    return object;
})



module.exports = model('Category', CategoryReportSchema );