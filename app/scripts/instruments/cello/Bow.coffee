define ['InstrumentComponent'], (InstrumentComponent)->

  class Bow extends InstrumentComponent
    constructor: (name, manifest)->
      super(name, manifest)
      @setup()
      @mouseDown = false
      @mouseEnabled = false

    setup: ->
      @regY = @height - 20
      @regX = @width / 2

    parseManifest: (manifest)->
      super(manifest)

    addItem: (name, data, image)=>
      bow = new createjs.Bitmap(image)
      bow.register = ->
      bow.deregister = ->
      @addChild(bow)
      @items.push(bow)

    handleMouseDown: (e)=>
      @mouseDown = true

    handlePressUp: (e)=>
      @mouseDown = false