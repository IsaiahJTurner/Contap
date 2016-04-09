var express = require('express');
var needle = require('needle');
var async = require('async');
var cookieParser = require('cookie-parser')
var app = express();
app.set('port', (process.env.PORT || 3005));
app.use(cookieParser());

app.get("/memes", function(req, res) {
  res.sendFile(__dirname + "/public/memes.html");
});
app.get("*", function(req, res) {
  res.send("https://www.youtube.com/watch?v=dQw4w9WgXcQ");
});
app.listen(app.get('port'), function() {
  console.log('Started on port ' + app.get("port") + '!');
});
