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
        res.set('Cache-Control', 'public, max-age=300, s-maxage=600');
        res.send(result)
    } catch (error) {
        res.status(500).send(error)
    }
})

app.get('/user', async (req, res) => {
    const user = {
        "name":  "Sabin Bir Bajracharya",
        "bio": "A fellow human 💕 Love building things over web | mobile | server... 💕 doing Dart, Kotlin, Rust and Node!!! Curated @elm 🐹🤖 with 🔥",
        "profile_pic_url": "https://gokatz.me/photo.jpg"
    }
    res.set('Cache-Control', 'public, max-age=300, s-maxage=600');
    res.send(user)
})

exports.api = functions.https.onRequest(app)

// https://firebase.google.com/docs/functions/http-events