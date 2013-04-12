mongoose = require("./connect").mongoose
db = require("./connect").db

stringHelper = require "../../../helpers/string"

moment = require "moment"

Schema = mongoose.Schema
ObjectId = mongoose.Schema.Types.ObjectId

ReplySchema = new Schema
  _id:
    type: String
    index: true
  name: 
    type: String
  desc: 
    type: String
    require: true
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
  forum:
    type: String
    ref: 'Forum'

ForumSchema = new Schema
  _id:
    type: String
    index: true
  name: 
    type: String
    required: true
    unique: true
  desc: 
    stype: String
  ip: 
    type: String
    required: true
  created:
    type: Date
    default: Date.now
  forum:
    type: String
    ref: 'Forum'

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
Forum = exports.Forum = db.model "Forum", ForumSchema
