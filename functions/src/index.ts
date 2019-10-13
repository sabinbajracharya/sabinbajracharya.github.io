import * as express from 'express';
import * as cors from 'cors';
import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

const app = express();
app.use(cors({ origin: true }));

admin.initializeApp();

app.get('/', async (req, res) => {
    try {
        res.send({message: "It Works!"})
    } catch (error) {
        res.status(500).send(error)
    }
})

app.get('/blogs', async (req, res) => {
    try {
        const db = admin.firestore()
        const blogsRef = db.collection('blog')
        const snapshot = await blogsRef.get()
        const result = snapshot.docs.map( doc => doc.data())

        res.send(result)
    } catch (error) {
        res.status(500).send(error)
    }
})

exports.api = functions.https.onRequest(app)

// https://firebase.google.com/docs/functions/http-events