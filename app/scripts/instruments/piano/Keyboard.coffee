define ['InstrumentComponent',
        'KeyFactory'], (InstrumentComponent, KeyFactory)->

  class Keyboard extends InstrumentComponent
    KEYSET_NEXT: 88
    KEYSET_PREV: 90

    constructor: (name, manifest)->
      super(name, manifest)
      @mouseDown = false

    register:->
      super()
      @on 'mousedown', @onMouseDown
      @on 'pressup', @onPressUp
      document.addEventListener 'keydown', @onKeyDown, false

    deregister: ->
      super()
      @removeAllEventListeners('mousedown')
      @removeAllEventListeners('pressup')
      document.removeEventListener 'keydown', @onKeyDown, false

    onMouseDown: (e)=>
      @mouseDown = true

    onPressUp: (e)=>
      @mouseDown = false

    onKeyDown: (e)=>
      if e.which == @KEYSET_NEXT
        @keyset++
        if @keyset > 5
          @keyset = 1

      else if e.which == @KEYSET_PREV
        @keyset--
        if @keyset < 1
          @keyset = 5

    addItem: (name, data, image)=>
      type = data.type
      key = KeyFactory.create(type, name, data, image, @)
      @addChild(key)
      @items.push(key)