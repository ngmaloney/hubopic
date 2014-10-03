# Description
#   Hubopic Images - A curated image album api
#
# Commands
# hubot hubopic list
# hubot <album> me
# hubot <album> bomb <count>

module.exports = (robot) ->
  robot.respond /hubopic list/i, (msg) ->
    Hubopic.list msg

  robot.respond /(\w+) me/i, (msg) ->
    album = msg.match[1]
    if album
      Hubopic.show msg, album

  robot.respond /(\w+) bomb( (\d+))?/i, (msg) ->
    album = msg.match[1]
    count = msg.match[2] || 5
    if album
      Hubopic.bomb msg, album, count

  robot.respond /how many (\w+) are there/i, (msg) ->
    album = msg.match[1]
    if album
      Hubopic.count msg, album

  robot.hear /crossfi/i, (msg) ->
    msg.send "Don't get caught in the CROSSFFFIAAAAH!"
    Hubopic.show msg, "crossfire"

#TODO Figure out how to make this a lib
Hubopic = {}
Hubopic.HOST = process.env.HUBOPIC_HOST || "http://hubopic.herokuapp.com"
Hubopic.list = (msg) ->
  msg.http(Hubopic.HOST + "/")
  .headers("Accept": "application/json")
  .get() (err, res, body) ->
    albums = JSON.parse(body).albums
    if albums.length > 0
      msg.send "The following albums are available:"
      msg.send album for album in JSON.parse(body).albums

Hubopic.show = (msg, album) ->
  msg.http(Hubopic.HOST + "/" + album)
    .headers("Accept": "application/json")
    .get() (err, res, body) ->
      photos = JSON.parse(body).photos
      if photos.length > 0
        msg.send msg.random photos

Hubopic.bomb = (msg, album, count) ->
  msg.http(Hubopic.HOST + "/" + album + "/bomb/" + count)
    .headers("Accept": "application/json")
    .get() (err, res, body) ->
      photos = JSON.parse(body).photos
      if photos.length > 0
        msg.send photo for photo in JSON.parse(body).photos

Hubopic.count = (msg, album, count) ->
  msg.http(Hubopic.HOST + "/" + album)
    .headers("Accept": "application/json")
    .get() (err, res, body) ->
      photos = JSON.parse(body).photos
      if photos.length > 0
        msg.send "There are #{photos.length} #{album}s"
