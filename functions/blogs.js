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

exports.handler = (event, context, callback) => {
    let blogRef = db.collection('blog');
    return blogRef.get()
        .then(snapshot => {
            if (snapshot.empty) {
                return callback(null, {
                    statusCode: 204,
                    body: JSON.stringify({ message: "No blog posts found." })
                });
            } else {
                return callback(null, {
                    statusCode: 200,
                    body: JSON.stringify({ data: "Data Found." })
                })
            }
        })
        .catch(err => {
            return callback(null, {
                statusCode: 400,
                body: JSON.stringify(error)
              })
        });
}