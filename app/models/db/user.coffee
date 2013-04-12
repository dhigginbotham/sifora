mongoose = require("./connect").mongoose
db = require("./connect").db

stringHelper = require "../../../helpers/string"

moment = require "moment"

Schema = mongoose.Schema
ObjectId = mongoose.Schema.Types.ObjectId

UserSchema = new Schema
  _id:
    type: String
    index: true
    unique: true
  email: 
    type: String
    required: true
    unique: true
  role:
    type: String
    require: true
    default: "Noob"
  name:
    first: String
    last: String
  dob: Date
  friends:
    type: String
    ref: "User"
  posts:
    type: String
    ref: "Forum"
  location: String
  joined: 
    type: Date
    required: true
    default: new Date()
  ip:
    type: String
    default: "not tracking this currently"

User = exports.User = db.model "User", UserSchema