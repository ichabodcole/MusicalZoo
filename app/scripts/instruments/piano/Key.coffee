define ['easel', 'ComponentItem'], (createjs, ComponentItem)->

  class Key extends ComponentItem
    constructor: (name, data, image)->
      super(name, data, image)


    register: ->
      console.log @parent
      @on 'mouseover', @playSoundOnMouseOver
      @on 'mousedown', @playSoundOnMouseDown
      document.addEventListener 'keydown', @handleKeyDown, false

    deregister: ->
      @off 'mouseover', @playSoundOnMouseOver
      @off 'mousedown', @playSoundOnMouseDown
      document.removeEventListener 'keydown', @handleKeyDown, false

    playSoundOnMouseOver: (e)=>
      if @parent.mouseDown == true
        @playSound()

    playSoundOnMouseDown: (e)=>
      @playSound()
