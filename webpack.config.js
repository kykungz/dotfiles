const path = require('path')

module.exports = {
  entry: './src/chooser.ts',
  mode: 'production',
  target: 'node',
  node: {
    __dirname: false,
  },
  resolve: {
    extensions: ['.ts', '.js'],
  },
  module: {
    rules: [{ test: /\.ts$/, loader: 'ts-loader', exclude: /node_modules/ }],
  },
  output: {
    filename: 'dotfiles.js',
    path: path.resolve(__dirname, 'dist'),
  },
}
