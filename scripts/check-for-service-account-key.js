const chalk = require('chalk')
const fs = require('fs');
const path = require('path');

const fullPath = path.join(__dirname, '/../serviceAccountKey.json');

function checkForServiceAccountKey() {
    try {
        if (!fs.existsSync(fullPath)) {
            console.log(chalk.yellow('Required Firebase Service Account json file not found in project root directory.'))
            console.log(`
==================================================================================================================
  You can create Firebase Service Account Key here: https://console.firebase.com
  Download the key and rename it to "serviceAccountKey.json" and then put it in the root directory of the project.
==================================================================================================================
            `)
            process.exit(1)
        }
      } catch(err) {
        console.error(err)
        process.exit(1)
      }
}

checkForServiceAccountKey();