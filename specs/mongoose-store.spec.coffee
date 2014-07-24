'use strict'

expect        = require('chai').expect
session       = require 'express-session'
mongoose      = require 'mongoose'
MongooseStore = require('../index') session

describe "Mongoose store", ->
  mongooseStore = null
  data =
    sid: '12ab34cd56ef'
    session:
      cookie:
        originalMaxAge: new Date().getTime() + 2000
        maxAge: new Date().getTime() + 2000
        httpOnly: true
      name: 'mongooseStore'


  before ->
    mongooseStore = new MongooseStore
      url: 'mongodb://127.0.0.1:27017/testing'
      ttl: 8


  after ->
    do mongooseStore.SessionModel.remove
    do mongoose.connection.close


  it "should set a session", (done) ->
    mongooseStore.set data.sid, data.session, (err, res) ->
      expect(res).to.equal 1
      do done


  it "should get a session", (done) ->
    mongooseStore.get data.sid, (err, res) ->
      expect(res.name).to.equal 'mongooseStore'
      do done


  it "should update a session", (done) ->
    data.session.name = 'sessionName'
    mongooseStore.set data.sid, data.session, (err, res) ->
      expect(res).to.equal 1

      mongooseStore.get data.sid, (err, res) ->
        expect(res.name).to.equal 'sessionName'
        do done


  it "should set createdAt field", (done) ->
    data.sid = '9Fs76dXs67Mnn2'
    mongooseStore.set data.sid, data.session, (err, res) ->
      expect(res).to.equal 1

      mongooseStore.SessionModel.findOne sid: data.sid, (err, res) ->
        expect(res.createdAt).to.be.ok
        do done


  it "should not get an expire session by TTL", (done) ->
    this.timeout 10000
    setTimeout ->
      mongooseStore.get data.sid, (err, res) ->
        expect(err).to.not.be.ok
        expect(res).to.equal 1
        do done
    , 8000


  it "should destroy a session", (done) ->
    mongooseStore.destroy data.sid, (err, res) ->
      expect(err).to.not.be.ok
      expect(res).to.equal 0
      do done


  it "should not get an expire session", (done) ->
    this.timeout 5000
    mongooseStore.set data.sid, data.session, (err, res) ->
      expect(res).to.equal 1

      setTimeout ->
        mongooseStore.get data.sid, (err, res) ->
          expect(res).to.equal 1
          do done
      , 2000


  it "should not get a session", (done) ->
    mongooseStore.get 'a123kda2', (err, res) ->
      expect(res).to.not.be.ok
      do done