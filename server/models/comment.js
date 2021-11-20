
const { Schema, model } = require('mongoose');

/* COmentarios a la app */
const CommentSchema = Schema({

    user: {
        type: Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    comment: {
        type: String,
        required: true
    },


}, {
    timestamps: true
});

CommentSchema.method('toJSON', function() {
    const { __v, ...object } = this.toObject();
    return object;
})



module.exports = model('Comment', CommentSchema );