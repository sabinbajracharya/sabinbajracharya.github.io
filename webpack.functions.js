// Fix: Lambda timeout and bunch of warnings when using firebase database
// https://github.com/netlify/netlify-lambda/issues/112#issuecomment-488644361

const nodeExternals = require('webpack-node-externals');

module.exports = {
  externals: [nodeExternals()],
};