require("coffee-script").register()
ivona = require './ivona.coffee'
module.exports = (slave) ->
  slave.on 'output', (text) ->
    ivona.speak text
  

