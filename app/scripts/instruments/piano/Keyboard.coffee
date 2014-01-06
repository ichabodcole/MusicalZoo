define ['InstrumentComponent',
        'KeyFactory'], (InstrumentComponent, KeyFactory)->

  class Keyboard extends InstrumentComponent
    constructor: (name, manifest)->
      super(name, manifest)
      @mouseDown = false

    register:->
      super()
      @on 'mousedown', @handleMouseDown
      @on 'pressup', @handlePressUp

    deregister: ->
      super()
      @removeAllEventListeners('mousedown')
      @removeAllEventListeners('pressup')

    handleMouseDown: (e)=>
      @mouseDown = true

    handlePressUp: (e)=>
      @mouseDown = false

    addItem: (name, data, image)=>
      type = data.type
      key = KeyFactory.create(type, name, data, image, @)
      @addChild(key)
      @items.push(key)