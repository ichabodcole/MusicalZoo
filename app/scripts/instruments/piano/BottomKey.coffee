define ['Key'], (Key)->

  class BottomKey extends Key
    constructor: (name, data, image)->
      @keyLine
      @keyLineLength = 8
      @keyLineStartX = 7
      @keyLineStartY = 44.5
      super(name, data)
      @setup(data, image)

    setup: (data, image)->
      super(data)
      @addHitArea(image)
      @addKeyLine(data.x, data.y)

    addHitArea: (image)->
      hitArea = new createjs.Bitmap(image)
      @hitArea = hitArea

    animate: ->
      @keyLine.y += 4
      setTimeout ()=>
        @keyLine.y = @keyLineStartY
      , 150

    addKeyLine: (x, y)->
      @keyLine = new createjs.Shape()
      @keyLine.x = @keyLineStartX
      @keyLine.y = @keyLineStartY
      @keyLine.graphics.beginStroke('#ffffff')
      @keyLine.graphics.moveTo(x, 0).lineTo(x+@keyLineLength, 0)
      @addChild(@keyLine)
