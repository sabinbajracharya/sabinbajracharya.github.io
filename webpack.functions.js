// Fix: Lambda timeout and bunch of warnings when using firebase database
// https://github.com/netlify/netlify-lambda/issues/112#issuecomment-488644361

/* fix for https://medium.com/@danbruder/typeerror-require-is-not-a-function-webpack-faunadb-6e785858d23b */

const nodeExternals = require('webpack-node-externals');

module.exports = {
  plugins: [
    new webpack.DefinePlugin({ "global.GENTLY": false })
  ],
  node: {
    __dirname: true,
  },
  externals: [nodeExternals()],
};