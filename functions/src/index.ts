import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();

export const blogs = functions.https.onRequest(async (request, response) => {
    try {
        const db = admin.firestore()
        const blogsRef = db.collection('blog')
        const snapshot = await blogsRef.get()
        const result = snapshot.docs.map( doc => doc.data())

        response.send(result)
    } catch (error) {
        response.status(500).send(error)
    }
});
