'use strict'

mongoose = require 'mongoose'
Schema   = mongoose.Schema

module.exports = (ttl) ->
  sessionSchema = new Schema
    sid: String
    session: {},
    expires:
      type: Date
      index: true
    createdAt:
      type: Date,
      expires: ttl

  mongoose.model 'Session', sessionSchema