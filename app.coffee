express = require "express"
app = module.exports = express()
server = require("http").createServer(app)
io = require("socket.io").listen(server)

fs = require "fs"
path = require "path"

forum = require "./app/models/forum"

app.configure () ->
  app.set "port", process.env.port
  app.set "views", __dirname + "/app/views"
  app.set "view engine", "mmm"
  app.set "layout", "layout"
  app.use express.favicon()
  app.use express.logger "dev"
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser "some-secret-password"
  app.use express.session 
    secret: "some-secret"
  app.use app.router
  app.use require("less-middleware") 
    src: __dirname + "/public/css"
  app.use express.static path.join __dirname, "public"

app.configure "production", () ->
  app.use express.errorHandler()

app.configure "development", () ->
  app.set "port", 3001
  app.use express.errorHandler 
    dumpExceptions: true
    showStack: true

app.get "/", (req, res) ->
  res.send "hello"

server.listen app.get("port"), () ->
  console.log "Express server listening on port #{app.get("port")} in #{app.settings.env} mode"
