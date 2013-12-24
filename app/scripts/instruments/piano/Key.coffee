define ['easel', 'ComponentItem'], (createjs, ComponentItem)->

  class Key extends ComponentItem
    constructor: (name, data, image)->
      super(name, data, image)

    register: ->
      @on 'mouseover', @playSound
      @on 'click', @playSound
      document.addEventListener 'keydown', @handleKeyDown, false

    deregister: ->
      @off 'mouseover', @playSound
      @off 'click', @playSound
      document.removeEventListener 'keydown', @handleKeyDown, false
