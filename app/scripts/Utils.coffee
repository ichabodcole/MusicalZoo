define [], ->
  class Utils

    @makePianoKeyJson: ->
      json = ""
      start = 1
      end   = 88
      topKeyStart = 53
      for i in [start..end]
        ki = i

        if ki >= topKeyStart
          prefix = 'tk_'
          keyType = 'top'
          ki -= 52
        else
          prefix = 'bk_'
          keyType = 'bottom'

        ki = if ki < 10 then "0"+ki else ki

        json += "{\n
          \"id\":\"#{ prefix + ki }\",\n
          \"type\": \"#{ keyType }\",\n
          \"keyInput\": 80,\n
          \"coords\": {\n
            \"width\":8, \"height\":20,\n
            \"x\":#{ (i-1) * 8.6 }, \"y\":45.5, \"z\":#{ i }\n
          },\n
          \"imgSrc\": \"#{ prefix + ki }\",\n
          \"soundSrc\": \"k_#{ ki }\"\n
          },"
      return json


    @centerOnStage: (stage, obj, width, height)->
      height = height || false
      obj.x = stage.canvas.width/2 - width/2
      if height
        obj.y = stage.canvas.height/2 - height/2


    @centerRegistration: (obj, width, height, adjustPos)->
      adjustPos = adjustPos || true
      obj.regX = width / 2
      obj.regY = height / 2
      if adjustPos == true
        obj.x += width / 2
        obj.y += height/ 2


