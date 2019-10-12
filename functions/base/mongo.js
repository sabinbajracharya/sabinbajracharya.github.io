const MongoClient = require("mongodb").MongoClient;
const ObjectId = require("mongodb").ObjectID;

const CONNECTION_URL = process.env.CONNECTION_URL;
const DATABASE_NAME = process.env.DATABASE_NAME;

const mongo = () => {
    return MongoClient.connect(CONNECTION_URL, {
        useNewUrlParser: true,
        useUnifiedTopology: true
    });
}

module.exports.mongo = mongo;
module.exports.DATABASE_NAME = DATABASE_NAME;