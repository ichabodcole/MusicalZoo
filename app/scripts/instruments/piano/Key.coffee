define ['easel', 'ComponentItem'], (createjs, ComponentItem)->

  class Key extends ComponentItem
    constructor: (name, data, image)->
      super(name, data, image)

    setup: (image, data)->
      super(image, data)
      @x = @y = 0

    register: ->
      super()
      @on 'mouseover', @handleOnMouseOver
      @on 'mousedown', @handleOnMouseDown

    deregister: ->
      super()
      @off 'mouseover', @handleOnMouseOver
      @off 'mousedown', @handleOnMouseDown

    handleOnMouseOver: (e)=>
      if @parent.mouseDown == true
        @playSound()

    handleOnMouseDown: (e)=>
      @playSound()
