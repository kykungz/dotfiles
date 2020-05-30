const path = require('path')

module.exports = {
  entry: './src/chooser.js',
  mode: 'production',
  target: 'node',
  node: {
    __dirname: false,
  },
  module: {
    rules: [
      {
        test: /\.m?js$/,
        exclude: /(node_modules|bower_components)/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: ['@babel/preset-env'],
          },
        },
      },
    ],
  },
  output: {
    filename: 'dotfiles.js',
    path: path.resolve(__dirname, 'dist'),
  },
}
