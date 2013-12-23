define ['PianoKey'], (PianoKey)->

  class PianoBottomKey extends PianoKey
    constructor: (data, keyboard)->
      @keyLine
      @keyLineLength = 8
      @keyLineStartX = 7
      @keyLineStartY = 44.5
      super data, keyboard

    setup: ->
      @addKeyLine(@coords.x, @coords.y)
      hitArea = new createjs.Bitmap(@image)
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
