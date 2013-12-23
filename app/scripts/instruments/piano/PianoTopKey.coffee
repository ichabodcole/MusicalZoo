define ['PianoKey'], (PianoKey)->

  class PianoTopKey extends PianoKey
    constructor: (data, keyboard)->
      super data, keyboard
      @startY = @y

    setup: ->
      bitmap = new createjs.Bitmap(@image)
      @addChild(bitmap)

    animate: ->
      @y += 2
      setTimeout ()=>
        @y = @startY
      , 150
