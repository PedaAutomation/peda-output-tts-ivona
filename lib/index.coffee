require("coffee-script").register()

ivona = require './ivona.coffee'

module.exports = (slave) ->
  slave.setType "output"
  slave.setName "tts"
  
  slave.on 'output', (data) ->
    ivona.speak data.data, data.language
  
