define ['easel', 'ComponentItem'], (createjs, ComponentItem)->

  class CelloString extends ComponentItem
    constructor: (name, data)->
      super(name, data)
      @setup(data)

    setup: (data)->
      super(data)
      @addHitArea(data)

    addHitArea: (data)->
      hit = new createjs.Shape()
      hit.graphics.beginFill('#00ADEE')
         .drawEllipse(data.x, data.y, data.width, data.height)
      # @hitArea = hit
      @addChild(hit)

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