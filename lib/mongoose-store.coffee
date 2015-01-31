'use strict'

mongoose = require 'mongoose'

module.exports = (session) ->
  class MongooseStore extends session.Store
    constructor: (@options = {}) ->
      mongoose.connect @options.url if mongoose.connection.readyState is 0
      @SessionModel = require('./model-session') @options.ttl


    get: (sid, callback) ->
      query = sid: sid

      @SessionModel.findOne query, (err, data) =>
        if err or not data then return callback err
        cookie = data.session.cookie
        if cookie.expires? and new Date() > cookie.expires
          return @destroy data.sid, callback
        callback null, data.session


    set: (sid, session, callback) ->
      unless session
        @destroy sid, callback

      data = sid: sid, session: session

      if cookie = session.cookie
        data.expires = cookie._expires if cookie._expires
        data.expires = cookie.expires if cookie.expires

      if @options.ttl then data.createdAt = new Date()

      @SessionModel.update sid: sid, data, upsert: true, callback


    destroy: (sid, callback) ->
      @SessionModel.remove(sid: sid).exec callback
