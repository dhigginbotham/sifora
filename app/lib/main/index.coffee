express = require "express"
app = module.exports = express()

# default route
app.get "/", (req, res) ->
  res.send "hello"
