fs = require 'fs'
lame = require 'lame'
Speaker = require 'speaker'
http  = require 'http'
https = require 'https' 
aws4  = require 'aws4'

language = "de-DE"
tempFile = "temp.mp3"

speak = (text) ->
 
  fileStream = fs.createWriteStream tempFile 
  
  fileStream.on 'close', ->
    fs.createReadStream tempFile
    .pipe new lame.Decoder()
    .on 'format', (format) ->
      this.pipe new Speaker (format)

  opts = { 
    host: 'tts.eu-west-1.ivonacloud.com', 
    path: '/CreateSpeech?Input.Data='+ text + '&Input.Type=text%2Fplain&OutputFormat.Codec=MP3&OutputFormat.SampleRate=22050&Parameters.Rate=slow&Voice.Name=Marlene&Voice.Language=' + language 
  }
  aws4.sign opts 
  https.request opts, (res) ->
   res.pipe fileStream 
  .end()

module.exports.speak = speak