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
    try{
        let citiesRef = db.collection('blog');
        // let snapshot = await citiesRef.get();
        if (true) {
            return {
                statusCode: 204,
                body: JSON.stringify({ message: "No blog posts found." })
            };
        } else {
            return {
                statusCode: 200,
                body: JSON.stringify({ data: "Data found."})
            };
        }
    } catch (e) {
        return {
            statusCode: 200,
            body: JSON.stringify({ message: "Something went wrong." })
        };
    }
};