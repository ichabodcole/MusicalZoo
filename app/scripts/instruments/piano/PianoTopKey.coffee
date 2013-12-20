define ['PianoKey'], (PianoKey)->

  class PianoTopKey extends PianoKey
    constructor: (data, keyboard)->
      super data, keyboard
      @startY = @getDisplayObj().y

    setup: ->
      bitmap = new createjs.Bitmap(@image)
      @getDisplayObj().addChild(bitmap)

    animate: ->
      @getDisplayObj().y += 2
      setTimeout ()=>
        @getDisplayObj().y = @startY
      , 150
