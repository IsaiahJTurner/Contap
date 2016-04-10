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
    needle.post('https://api.contactually.com/v2/contacts', '{\
  "data": {\
    "first_name": "' + contactInfo.name + '",\
    "last_name": "",\
    "company": null,\
    "title": "' + contactInfo.name + '",\
    "avatar_url": null,\
    "email_addresses": [\
      {\
        "label": null,\
        "address": "' + contactInfo.email + '"' +
        '}\
    ]\
  }\
}', {
            json: true,
            headers: {
              Authorization: "Bearer 5c678fa1c39749d9859a93e651ff959f33e0ecf494a12cdc27e127f51e653bb9"
            }

        },
        function(err, resp) {
            console.log(err, resp)
        })
    sp.transmissions.send({
        transmissionBody: {
            content: {
                from: 'testing@sparkpostbox.com',
                subject: 'You connected with ' + req.query.name,
                reply_to: req.query.email,
                html: 'You connected with ' + req.query.name + '. Reply to this email to this email to contact them.<br><br>Thanks, <br>Contap</p>',
            },
            recipients: [{
                address: contactInfo.email
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
    sp.transmissions.send({
        transmissionBody: {
            content: {
                from: 'testing@sparkpostbox.com',
                subject: 'You connected with ' + contactInfo.name,
                html: 'You connected with ' + contactInfo.name + '. Reply to this email to this email to contact them.<br><br>Thanks, <br>Contap</p>',
                reply_to: contactInfo.email
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
    sp.transmissions.send({
        transmissionBody: {
            content: {
                from: 'testing@sparkpostbox.com',
                subject: 'You connected with ' + req.query.name,
                html: '<html><body><p>Hi ' + req.query.name + ',<br/> You are now connected with Hillary Sanders. She will reach out to you shortly.<br><br>Thanks, <br>Contap</p></body></html>'
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
