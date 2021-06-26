const path = require("path");
const webpack = require("webpack");

module.exports = (env, arg) => {
  return {
    plugins: [new webpack.HotModuleReplacementPlugin()],
    devServer: {
      hot: true,
      stats: "errors-only",
      port: 3000,
      host: "0.0.0.0",
      historyApiFallback: {
        rewrites: [{ from: /.*/, to: "/" }],
      },
    },
    entry: "./src/index.ts",
    output: {
      filename: "main.js",
      path: path.resolve(__dirname),
    },
    module: {
      rules: [
        {
          test: /\.elm$/,
          exclude: ["/elm-stuff/", "/node_modules/"],
          use: [
            { loader: "elm-hot-webpack-loader" },
            {
              loader: "elm-webpack-loader",
              options: {
                cwd: __dirname,
                optimize: arg.mode == "production" ? true : false,
                debug: arg.mode == "development" ? true : false,
              },
            },
          ],
        },
        {
            test: /\.ts$/,
            use: "ts-loader"
        }
      ],
    },
    resolve: {
      extensions: [".ts", ".js", ".elm"],
    },
  };
};
