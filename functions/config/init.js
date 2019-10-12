const fs = require('fs');
const path = require('path');
const fullPath = path.resolve(process.cwd(), 'serviceAccountKey.json')

function setEnvironment() {
    try {
        if (fs.existsSync(fullPath)) {
            let rawdata = fs.readFileSync(fullPath, "utf8");
            let res = JSON.parse(rawdata);

            process.env.FB_TYPE = res.type;
            process.env.FB_PROJECT_ID = res.project_id;
            process.env.FB_PROJECT_KEY_ID = res.private_key_id;
            process.env.FB_PRIVATE_KEY = res.private_key;
            process.env.FB_CLIENT_EMAIL = res.client_email;
            process.env.FB_CLIENT_ID = res.client_id;
            process.env.FB_AUTH_URI = res.auth_uri;
            process.env.FB_TOKEN_URI = res.token_uri;
            process.env.FB_AUTH_PROVIDER = res.auth_provider_x509_cert_url;
            process.env.FB_CLIENT_X509 = res.client_x509_cert_url;
        }
    } catch(err) {
        console.error(err)
    }
}


const serviceAccount = () => {
    setEnvironment();

    return {
        "type": process.env.FB_TYPE,
        "project_id": process.env.FB_PROJECT_ID,
        "private_key_id": process.env.FB_PROJECT_KEY_ID,
        "private_key": process.env.FB_PRIVATE_KEY.replace(/\\n/g, '\n'),
        "client_email": process.env.FB_CLIENT_EMAIL,
        "client_id": process.env.FB_CLIENT_ID,
        "auth_uri": process.env.FB_AUTH_URI,
        "token_uri": process.env.FB_TOKEN_URI,
        "auth_provider_x509_cert_url": process.env.FB_AUTH_PROVIDER,
        "client_x509_cert_url": process.env.FB_CLIENT_X509
    }
}

module.exports = serviceAccount;