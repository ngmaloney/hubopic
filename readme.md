Hubopic
========

A static image hosting API for serving hubot images.

Deploying
---------
[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy?template=https://github.com/ngmaloney/hubopic)

HTTP Endpoints
--------------

Hubopic is a simple sinatra app that serves up any images in the public/images
folder as json. It supports the following endpoints:

    # List all available albums
    GET /

    # List all images in an album
    GET /:album

    # Return a random image from an album
    GET /:album/random

    # Return a specified count of images
    GET /:album/bomb/:count

Hubot Commands
--------------

The corresponding hubot script can be found in /vendor/scripts/hubopic.coffee.
It follows the "pugbomb" command conventions.

    Hubot Commands
    # List available albums
    hubopic list
    # Returns a random album image
    <album> me
    # Bomb a room with photos
    <album> bomb <count> (optional)
    # List album image count
    How many <album> are there


Adding Images
-------------
Create a folder in public/images and issue a pull request. Actively seeking
image albums of puppies, kittens and yummy food.
