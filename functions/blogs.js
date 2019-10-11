const admin = require('firebase-admin');
let serviceAccount = require('../serviceAccountKey.json');

const app = admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: "https://peronal-blog.firebaseio.com",
})

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