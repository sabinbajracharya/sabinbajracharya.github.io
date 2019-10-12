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
    let citiesRef = db.collection('blog');
    let snapshot = await citiesRef.get();
    if (snapshot.empty) {
        return {
            statusCode: 200,
            body: JSON.stringify({ message: "No blog posts found." })
        };
    } else {
        return {
            statusCode: 200,
            body: JSON.stringify({ data: snapshot.docs.map( doc => doc.data()) })
        };
    }
};