define ['easel', 'ComponentItem'], (createjs, ComponentItem)->

  class Drum extends ComponentItem
    constructor: (name, data, image)->
      super(name, data, image)

    animate: ->
      @scaleX = .95
      @scaleY = .95

      setTimeout =>
        @scaleX = 1
        @scaleY = 1
      , 50
