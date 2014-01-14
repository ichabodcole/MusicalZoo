define ->
  class Utils
    # creates and returns a bitmap,
    # optionally uses a data attribute to set initial values on the bitmap
    @createBitmapFromResult: (q, id, useDataAttr)->
      result = q.getResult(id)
      bitmap = new createjs.Bitmap(result)
      bitmap.name = id
      #
      if useDataAttr == true
        item = q.getItem(id)
        data = item.data
        # if there is a data attribute set the values on the bitmap
        if data? then @setObjectData(bitmap, data)
      return bitmap

    # iterate through an object and set its values on another object
    @setObjectData: (obj, data)->
      for key, value of data
        obj[key] = value

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


