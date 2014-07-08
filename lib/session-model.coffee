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
      expires: ttl || 3600

  mongoose.model 'Session', sessionSchema