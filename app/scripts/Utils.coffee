define [], ->
  class Utils

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
      topKeyStart = 53
      keyIndex = i
      if i >= topKeyStart
        prefix = 'tk_'
        keyType = 'top'
        keyIndex -= 52
      else
        prefix = 'bk_'
        keyType = 'bottom'
      keyIndex = @addLeadingZero(keyIndex)
      stringIndex = @addLeadingZero(i)
      #
      return "{\n
        \"id\":\"k_#{ stringIndex }\",\n
        \"src\": \"#{ prefix + keyIndex }.png\",\n
        \"data\": {\n
          \"type\": \"#{keyType}\",\n
          \"keyInput\": 80,\n
          \"width\": 8.6,\n
          \"height\": 20,\n
          \"x\":#{ (i-1) * 8.6 },\n
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

    @centerOnStage: (stage, obj, width, height, adjustForSize)->
      adjustForSize = adjustForSize ? true
      height = height ? false
      newX = stage.canvas.width/2
      obj.x = if adjustForSize then newX - width/2 else newX
      if height
        newY = stage.canvas.height/2
        obj.y = if adjustForSize then newY - height/2 else newY

    @centerRegistration: (obj, width, height, adjustPos)->
      adjustPos = adjustPos ? true
      obj.regX = width / 2
      obj.regY = height / 2
      if adjustPos == true
        obj.x += width / 2
        obj.y += height/ 2


