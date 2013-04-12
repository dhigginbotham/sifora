mongoose = exports.mongoose = require "mongoose"

bcrypt = require "bcrypt"

stringHelper = require "../../helpers/string"

SALT_WORK_FACTOR = 20

moment = require "moment"

Schema = mongoose.Schema

ObjectId = mongoose.Schema.Types.ObjectId

DB_CONNECTION_STRING = process.env.XFM_STRING || "mongodb://localhost/xfmc"

mongoose.connect DB_CONNECTION_STRING

db = mongoose.connection

db.on "error", console.error.bind console, "connection error:"

db.once "open", () ->
  console.log "Connected to #{DB_CONNECTION_STRING}"


ReplySchema = new Schema
  _id:
    type: String
    index: true
  name: 
    type: String
    required: true
    unique: true
  desc: String
  ip: 
    type: String
    required: true
  created:
    type: Date
    default: Date.now

ThreadSchema = new Schema
  _id:
    type: String
    index: true
  name: 
    type: String
    required: true
    unique: true
  desc: String
  ip: 
    type: String
    required: true
  created:
    type: Date
    default: Date.now
  replies:
    type: [ ReplySchema ]

ThreadSchema.statics.process = processThread = (thread) ->
  thread["replies-count"] = thread.replies.length
  thread["created-date"] = moment(new Date(thread.created)).fromNow()
  thread["thread-id"] = thread._id
  if thread.email is "" then thread["has-email"] = false else thread["has-email"] = true

ThreadSchema.pre "save", (next) ->
  @slug = stringHelper.slugify @title
  next()

ThreadSchema.statics.processThread = (threads) ->
  threads.forEach processThread

Reply = exports.Reply = db.model "Reply", ReplySchema
Thread = exports.Thread = db.model "Thread", ThreadSchema
