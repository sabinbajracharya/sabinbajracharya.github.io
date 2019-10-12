const MongoClient = require("mongodb").MongoClient;
const ObjectId = require("mongodb").ObjectID;

const CONNECTION_URL = process.env.CONNECTION_URL;
const DATABASE_NAME = process.env.DATABASE_NAME;

exports.handler = async (event, context) => {
    let client = await MongoClient.connect(CONNECTION_URL);
    let db = client.db(DATABASE_NAME)

    try {
        let res = await db.collection('myMovies').find({}).toArray();
        return {
            statusCode: 200,
            body: JSON.stringify({ data: res})
        };
    } catch (e) {
        return {
            statusCode: 204,
            body: JSON.stringify({ message: "No content found!" })
        };
    } finally {
        client.close();
    }
};