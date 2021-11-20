const User = require('../models/user');
const Message = require('../models/message');


const userConnected = async( id ) => {

    const user = await User.findById(id);
    user.online = true;
    await user.save();
    return user;

}


const userDisconnected = async( id ) => {

    const user = await User.findById(id);
    user.online = false;
    await user.save();
    return user;

}


const getAllUsers = async( ) => {
    
    const users = await User.find().sort('-online');
    return users;

}



const saveMessage = async( payload ) => {

    /* 
        {
            from: '',
            to: '',
            message: ''
        } 
    */

    try {

        const message = new Message( payload )
        await message.save();

    } catch(error) {
        console.log(error);
        return false;
    }

}

module.exports = {
    userConnected,
    userDisconnected,
    getAllUsers,
    saveMessage
}