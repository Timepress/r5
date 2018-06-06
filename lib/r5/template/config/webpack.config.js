const path = require('path');
const VueLoaderPlugin = require('vue-loader/lib/plugin')
const WriteAssetsWebpackPlugin = require('write-assets-webpack-plugin');
const WebpackWatchFilesPlugin = require('webpack-watch-files-plugin').default
const UglifyJsPlugin = require('uglifyjs-webpack-plugin')
const WriteFilePlugin = require('write-file-webpack-plugin');

const Webpack = require('webpack')

const config = (env, argv) => {

  const config = {
    mode: argv.mode,
    entry: path.resolve(__dirname, '../app/assets/webpack/index.js'),
    output: {
      filename: 'webpack.bundle.js',
      path: path.resolve(__dirname, '../app/assets/javascripts')
    },
    module: {
      rules: [
        {
          test: /\.js$/,
          use: [
            {
              loader: 'babel-loader',
              query: {
                presets: ['env']
              }
            },
            {
              loader: 'webpack-preprocessor-loader',
              options: {
                params: {
                  DEVELOPMENT: argv.mode === 'development',
                  PRODUCTION: argv.mode === 'production',
                }
              },
            },
          ]
        },
        {
          test: /\.scss/,
          use: [
            'vue-style-loader',
            'css-loader',
            'sass-loader'
          ]
        },
        {
          test: /\.css/,
          use: [
            'vue-style-loader',
            'css-loader'
          ]
        },
        {
          test: /\.vue$/,
          use: [
            {
              loader: 'vue-loader'
            }
          ]
        }
      ]
    },
    plugins: [
      new VueLoaderPlugin()
    ],
    devServer: {
      port: 9000,
      compress: true,
      watchContentBase: true,
      watchOptions: {
        ignored: /node_modules/
      }
    }
  }

  if (argv.mode === 'development') {
    const developmentPlugins = [
      new WriteAssetsWebpackPlugin({force: true, extension: ['js']}),
      new WebpackWatchFilesPlugin({
        files: [
          path.resolve(__dirname, '../app') + '/**/*.rb',
          path.resolve(__dirname, '../app') + '/**/*.erb',
        ]
      }),
      new WriteFilePlugin({
        test: /^(?!.*(hot)).*/,
      }),]

    config.plugins = [...config.plugins, ...developmentPlugins]
  } else {
    const productionPlugins = [
      new UglifyJsPlugin({
        parallel: true
      })
    ]
    config.plugins = [...config.plugins, ...productionPlugins]

  }
  return config
}


module.exports = config;