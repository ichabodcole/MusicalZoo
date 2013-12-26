define ['easel', 'ComponentItem', 'Utils'], (createjs, ComponentItem, Utils)->

  class Drum extends ComponentItem
    constructor: (name, data, image)->
      super(name, data)
      @setup(data, image)

    setup: (data, image)->
      super(data)
      @addImage(image)
      Utils.centerRegistration(@, @width, @height, true)

    addImage: (image)->
      bitmap = new createjs.Bitmap(image)
      @addChild(bitmap)

    register: ->
      super()
      @on 'click', @playSound

    deregister: ->
      super()
      @off 'click', @playSound

    animate: ->
      @scaleX = .95
      @scaleY = .95

      setTimeout =>
        @scaleX = 1
        @scaleY = 1
      , 50
