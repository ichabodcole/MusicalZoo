define ->
  class JsonExport
    @makePianoKeyJson: ->
      soundJson = ""
      imageJson = ""
      soundPath = "./sounds/piano/mp3/"
      imagePath = "../images/piano/"
      start = 1
      end   = 88

      for i in [start..end]
        imageJson += @makePianoImageJson(i)
        soundJson += @makePianoSoundJson(i)
      return {imageJson:imageJson, soundJson:soundJson}

    @makePianoImageJson: (i)->
      keyIndex    = i
      topKeyStart = 53
      #
      if i >= topKeyStart
        keyIndex -= 52
        xPos    = 0
        tkInput = [81, 87, 69, 84, 89, 85, 79, 80]
        keySet  = Math.floor((keyIndex-1)/(tkInput.length)) + 1
        prefix  = 'tk_'
        keyType = 'top'
        input   = (keyIndex-1) % tkInput.length
        kInput  = tkInput[input]
      else
        xPos    = Math.round(((i-1) * 8.6) * 10) / 10
        bkInput = [65, 83, 68, 70, 71, 72, 74, 75, 76, 186, 222]
        keySet  = Math.floor((i-1)/(bkInput.length)) + 1
        prefix  = 'bk_'
        keyType = 'bottom'
        input   = (i-1) % bkInput.length
        kInput  = bkInput[input]
      #
      keyIndex = @addLeadingZero(keyIndex)
      stringIndex = @addLeadingZero(i)
      #
      return "{\n
        \"id\":\"k_#{ stringIndex }\",\n
        \"src\": \"#{ prefix + keyIndex }.png\",\n
        \"data\": {\n
          \"type\": \"#{ keyType }\",\n
          \"keySet\": #{ keySet },\n
          \"keyInput\": #{ kInput },\n
          \"width\": 8.6,\n
          \"height\": 20,\n
          \"x\":#{ xPos },\n
          \"y\":0,\n
          \"z\":#{ i }\n
        }\n
      },"

    @makePianoSoundJson: (i)->
      prefix = "k_"
      i = @addLeadingZero(i)
      return "{\"id\":\"#{ prefix + i }_snd\", \"src\": \"#{ prefix + i }.mp3\"},\n"

    @addLeadingZero: (num)->
      if(num < 10)
        num = "0" + num
      num