var express = require('express');
var needle = require('needle');
var async = require('async');
var cookieParser = require('cookie-parser')
var app = express();
var SparkPost = require('sparkpost');
var sp = new SparkPost('7c247123769702176276c6dd238c4bdf3184c8d9');

var contactInfo = {};
var savedRes;
var contacts = [];

app.set('port', (process.env.PORT || 3005));
app.use(cookieParser());

app.get("/connect", function(req, res) {
    contacts.push({
        name: req.query.name || "Unknown " + Math.floor(Math.random() * 900) + 100,
        email: req.query.email
    });
    if (!savedRes) {
        contactInfo = req.query;
        savedRes = res;
        return;
    }
    sp.transmissions.send({
        transmissionBody: {
            content: {
                from: 'testing@sparkpostbox.com',
                subject: 'You connected with ' + req.query.name,
                html: '<html><body><p>Hi ' + req.query.name + ',<br/> You are now connected with Hillary Sanders. She will reach out to you shortly.</p></body></html>'
            },
            recipients: [{
                address: req.query.email
            }]
        }
    }, function(err, res) {
        if (err) {
            console.log('Whoops! Something went wrong');
            console.log(err);
        } else {
            console.log('Woohoo! You just sent your first mailing!');
        }
    });
    res.json(contactInfo);
    savedRes.json(req.query);
    savedRes = null;
});
app.get("/connect2", function(req, res) {
  contactInfo = false;
  savedRes = false;
});
app.get("/contacts", function(req, res) {
    res.json({
        contacts: contacts
    })
    contacts = [];
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
