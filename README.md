# mongoose-store [![Build Status](https://travis-ci.org/dreyacosta/mongoose-store.svg?branch=master)](https://travis-ci.org/dreyacosta/mongoose-store)
> Mongoose session store for Express

## Installation
```sh
$ npm install mongoose-store --save
```

## Usage

### Options
  - `url`: The URL connection format `mongodb://user:pass@host:port/database/collection`. Only need it if there is no connection yet.
  - `ttl` (seconds): How long the session persist on the database.

### Example
```js
var express       = require('express');
var session       = require('express-session');
var MongooseStore = require('mongoose-store')(session);

var app = express();

var mongooseStore = new MongooseStore({
  url: 'mongodb://127.0.0.1:27017/testing',
  ttl: 600
});

app.use(session({
  name: 'app.sid',
  secret: 'yoursecret',
  store: mongooseStore
}));
```

#### With replica set:
```js
var express       = require('express');
var session       = require('express-session');
var MongooseStore = require('mongoose-store')(session);

var app = express();

var mongooseStore = new MongooseStore({
  url: 'mongodb://ip1:27017/testing,mongodb://ip2:27017/testing,mongodb://ip3:27017/testing',
  ttl: 600
});

app.use(session({
  name: 'app.sid',
  secret: 'yoursecret',
  store: mongooseStore
}));
```