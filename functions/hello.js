const admin = require('firebase-admin');
let serviceAccount = require('./config/init.js')();

exports.handler = async (event, context) => {
    return {
        statusCode: 200,
        body: JSON.stringify({ text: `Sabin says hello!` })
    };
};