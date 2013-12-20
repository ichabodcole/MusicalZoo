define ['Instrument'], (Instrument)->

  class Cello extends Instrument
    constructor: ->
      super
      @bgImage  = null
      @bgBitmap = null
      @keyBoard = new createjs.Container()

    addBgImage: ->
      obj = @getDisplayObj()
      @bgBitmap = new createjs.Bitmap(@bgImage)
      obj.addChild(@bgBitmap)

    parseManifestComplete: ->
      @addBgImage()