var express = require('express');
var needle = require('needle');
var async = require('async');
var cookieParser = require('cookie-parser')
var app = express();
var SparkPost = require('sparkpost');
var sp = new SparkPost('7c247123769702176276c6dd238c4bdf3184c8d9');

var contactInfo = {};
var savedRes;
sp.transmissions.send({
  transmissionBody: {
    content: {
      from: 'testing@sparkpostbox.com',
      subject: 'Hello, World!',
      html:'<html><body><p>Testing SparkPost - the world\'s most awesomest email service!</p></body></html>'
    },
    recipients: [
      {address: 'sparkpost@isaiahjturner.com'}
    ]
  }
}, function(err, res) {
  if (err) {
    console.log('Whoops! Something went wrong');
    console.log(err);
  } else {
    console.log('Woohoo! You just sent your first mailing!');
  }
});
app.set('port', (process.env.PORT || 3005));
app.use(cookieParser());

app.get("/connect", function(req, res) {
  if (!savedRes) {
    contactInfo = req.query;
    savedRes = res;
    return;
  }
  res.send(contactInfo);
  savedRes.send(req.query);
  savedRes = null;
});
app.get("/memes", function(req, res) {
  res.sendFile(__dirname + "/public/memes.html");
});
app.get("*", function(req, res) {
  res.send("https://www.youtube.com/watch?v=dQw4w9WgXcQ");
});
app.listen(app.get('port'), function() {
  console.log('Started on port ' + app.get("port") + '!');
});
