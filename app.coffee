express = require "express"
app = express()

passport = require "passport"

# make scket happy
server = require("http").createServer(app)
io = require("socket.io").listen(server)

fs = require "fs"
path = require "path"

# initialize forum bits
# this will likely be moved
forum = require "./app/models/db/forum"

# load bundle dependencies
main = require "./app/lib/main"
usersAuth = require "./app/lib/users-auth"

app.use main
app.use usersAuth

# configure app defaults
app.configure () ->
  app.set "port", process.env.port
  app.set "views", __dirname + "../app/views"
  app.set "view engine", "mmm"
  app.set "layout", "layout"
  app.use express.favicon()
  app.use express.logger "dev"
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser "some-secret-password"
  app.use express.session 
    secret: "some-secret"
  app.use passport.initialize()
  app.use passport.session()
  app.use app.router
  app.use require("less-middleware") 
    src: __dirname + "../../public/css"
  app.use express.static path.join __dirname, "public"

# configure production environment
app.configure "production", () ->
  app.use express.errorHandler()

# configure development environment
app.configure "development", () ->
  app.set "port", 3001
  app.use express.errorHandler 
    dumpExceptions: true
    showStack: true

# load this server up!
server.listen app.get("port"), () ->
  console.log "Express server listening on port #{app.get("port")} in #{app.settings.env} mode"
