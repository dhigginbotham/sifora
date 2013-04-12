express = require "express"
app = module.exports = express()

app.get "/login", (req, res) ->
  res.send "login"