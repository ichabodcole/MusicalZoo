define ->
  class Utils
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


