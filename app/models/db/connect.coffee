mongoose = exports.mongoose = require "mongoose"
bcrypt = require "bcrypt"
SALT_WORK_FACTOR = 20
DB_CONNECTION_STRING = process.env.XFM_STRING || "mongodb://localhost/xfmc"

mongoose.connect DB_CONNECTION_STRING
db = exports.db = mongoose.connection

db.on "error", console.error.bind console, "connection error:"

db.once "open", () ->
  console.log "Connected to #{DB_CONNECTION_STRING}"