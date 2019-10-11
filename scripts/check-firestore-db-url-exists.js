const chalk = require('chalk')

function checkForFirestoreDBUrl() {
  if (!process.env.FIRESTORE_DB_URL) {
    console.log(chalk.yellow('Required FIRESTORE_DB_URL enviroment variable not found.'))
    console.log(`
====================================================================================================
  You can get the Firebase Firestore Url here: https://console.firebase.com
  In your terminal run the following command:
  export FIRESTORE_DB_URL=YourFirebaseFirestoreKeyHere
====================================================================================================
    `)
    process.exit(1)
  }
}

checkForFirestoreDBUrl()