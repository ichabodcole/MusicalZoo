define ['InstrumentComponent'], (InstrumentComponent)->

  class Drum extends InstrumentComponent
    constructor: (data)->
      super data
      @setRegistrationCenter()

    animate: ->
      obj = @getDisplayObj()
      obj.scaleX = .95
      obj.scaleY = .95

      setTimeout =>
        obj.scaleX = 1
        obj.scaleY = 1
      , 50
