lame = require 'lame'
Speaker = require 'speaker'
https = require 'https' 
aws4  = require 'aws4'

VOICE_NAMES = {
  "de": "Hans",
  "en": "Brian",
  "dk": "Mads",
  "nl": "Ruben",
  "fr": "Mathieu",
  "it": "Giorgio",
  "pl": "Jacek",
  "ru": "Tatyana",
  "se": "Astrid",
  "tu": "Filiz"
}

speak = (text, language) ->
  
  language = language || "de"
  
  voice = VOICE_NAMES[language]
  
  
  opts = { 
    region: 'eu-west-1',
    service: 'tts',
    host: 'tts.eu-west-1.ivonacloud.com', 
    path: "/CreateSpeech?Input.Data=#{encodeURIComponent(text)}&Input.Type=text%2Fplain&OutputFormat.Codec=MP3&OutputFormat.SampleRate=22050&Voice.Name=#{voice}" 
  }
  aws4.sign opts, { accessKeyId: process.env.IVONA_ACCESS_KEY, secretAccessKey: process.env.IVONA_SECRET_KEY }

  https.request opts, (res) ->
    res.pipe new lame.Decoder()
    .on 'format', (format) ->
      this.pipe new Speaker (format)
  .end()

module.exports.speak = speak
