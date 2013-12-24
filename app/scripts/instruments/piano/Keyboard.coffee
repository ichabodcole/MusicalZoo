define ['InstrumentComponent',
        'KeyFactory'], (InstrumentComponent, KeyFactory)->

  class Keyboard extends InstrumentComponent
    constructor: (name, manifest)->
      super(name, manifest)
      @mouseDown = false

    register:->
      @on 'mousedown', @handleMouseDown
      @on 'pressup', @handlePressUp

    deregister: ->
      @off 'mousedown', @handleMouseDown
      @off 'pressup', @handlePressUp


    handleMouseDown: (e)=>
      @mouseDown = true

    handlePressUp: (e)=>
      @mouseDown = false


    addItem: (name, data, image)=>
      type = data.type
      key = KeyFactory.create(type, name, data, image, @)

      @addChild(key)
      key.register()