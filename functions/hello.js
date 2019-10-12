const admin = require('firebase-admin');
let serviceAccount = require('./config/init.js')();

let app = null;

try {
    app = admin.app();
} catch (error) {
    app = admin.initializeApp({
        credential: admin.credential.cert(serviceAccount),
        databaseURL: process.env.FIRESTORE_DB_URL,

    });
}

let db = admin.firestore();

exports.handler = async (event, context) => {
    return {
        statusCode: 200,
        body: JSON.stringify({ text: `Sabin says hello!` })
    };
};