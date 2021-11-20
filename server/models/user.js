

const { Schema, model } = require('mongoose');


const UserSchema = Schema({

    name: {
        type: String,
        required: true
    },
    email: {
        type: String,
        required: true,
        unique: true
    },
    password: {
        type: String,
        required: true,
    },
    /* municipality: {
        type: String,
    }, */
    image: {
        type: String
    },
     /* ADMIN_ROLE, INSTITUTE_ROLE */
    role: {
        type: String,
        required: true,
        default: 'USER_ROLE'
    },
    online: {
        type: Boolean,
        default: false,
    },
    /* SOLO PARA IDAIPQROO */
    description: {
        type: String
    },
    institute: {
        type: Schema.Types.ObjectId,
        ref: 'Institute',
    }

});


UserSchema.method('toJSON', function(){
    const { __v, password,  ...object } = this.toObject();
    // object.uid = _id
    return object;
});



module.exports = model( 'User', UserSchema );