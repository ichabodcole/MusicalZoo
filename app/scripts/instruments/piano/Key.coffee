define ['easel', 'ComponentItem'], (createjs, ComponentItem)->

  class Key extends ComponentItem
    constructor: (name, data)->
      super(name, data)

    setup: (data)->
      super(data)
      @x = @y = 0

    register: ->
      super()
      @on 'mouseover', @handleOnMouseOver
      @on 'mousedown', @handleOnMouseDown

    deregister: ->
      super()
      @removeAllEventListeners('mouseover')
      @removeAllEventListeners('mousedown')

    handleOnMouseOver: (e)=>
      if @parent.mouseDown == true
        @playSound()

    handleOnMouseDown: (e)=>
      @playSound()
