require("coffee-script").register()

ivona = require './ivona.coffee'

module.exports = (slave) ->
  slaveHelper.setType "output"
  slaveHelper.setName "tts"
  
  slave.on 'output', (text) ->
    ivona.speak text
  
