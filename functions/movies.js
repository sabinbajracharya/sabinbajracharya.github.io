require('./config/env')();
const { mongo, DATABASE_NAME } = require("./base/mongo");

exports.handler = async (event, context) => {
    let client = await mongo();
    let db = client.db(DATABASE_NAME);
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

exports.TEST = async () => {
    let client = await mongo();
    let db = client.db(DATABASE_NAME);
    try {
        let res = await db.collection('myMovies').find({}).toArray();
        console.log("res", JSON.stringify({ data: res}))
    } catch (e) {
        console.log("res", "No content found!");
    } finally {
        client.close();
    }
};