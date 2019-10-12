const admin = require('firebase-admin');
let serviceAccount = require('./config/init.js')();

let app = null;
console.log("credentials", JSON.stringify(serviceAccount));
console.log("Database", process.env.FIRESTORE_DB_URL);
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
    console.log("Blog", "In handler");
    try{
        let citiesRef = db.collection('blog');
        let snapshot = await citiesRef.get();
        console.log("Blog", snapshot.);
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