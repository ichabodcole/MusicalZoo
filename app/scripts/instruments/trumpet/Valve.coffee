define ['easel', 'ComponentItem'], (createjs, ComponentItem)->

  class Valve extends ComponentItem
    constructor: (name, data, image)->
      super(name, data)
      @startY # set in setup method
      @setup(data, image)
      @valveDownEvent = new createjs.Event('valveDown', true)
      @valveUpEvent = new createjs.Event('valveUp', true)
      createjs.EventDispatcher.initialize(@)

    setup: (data, image)->
      super(data)
      @startY = @y
      @addImage(image)

    addImage: (image)->
      @bgImage = new createjs.Bitmap(image)
      @addChild(@bgImage)

    register: ->
      super()
      @on('mousedown', @onMouseDown)
      @on('pressup', @onPressUp)

    deregister: ->
      super()
      @removeAllEventListeners('mousedown')
      @removeAllEventListeners('pressup')

    onKeyDown: (e)=>
      # console.log "You pressed the key:", e.which
      e.preventDefault()
      unless @keyDownFired
        if e.which == @keyInput
          @keyDownFired          = true
          @valveDownEvent.valve = @name
          @dispatchEvent(@valveDownEvent)
          @animate()

    onKeyUp: (e)=>
      super(e)
      if e.which == @keyInput
        @valveUpEvent.valve = @name
        @dispatchEvent(@valveUpEvent)
        @animate(false)

    onMouseDown: (e)=>
      @valveDownEvent.valve = @name
      @dispatchEvent(@valveDownEvent)
      @animate()

    onPressUp: (e)=>
      @valveUpEvent.valve = @name
      @dispatchEvent(@valveUpEvent)
      @animate(false)

    animate: (state)->
      if state == false
        @y = @startY
      else
        @y = @startY + 15