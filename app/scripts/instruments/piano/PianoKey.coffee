define ['InstrumentComponent'], (InstrumentComponent)->

  class PianoKey extends InstrumentComponent
    constructor: (data, @keyboard)->
      super data
      @getDisplayObj().mouseEnabled = true

    register: ->
      super
      @getDisplayObj().on 'mouseover', @handleMouseOver

    handleMouseOver: =>
      if @keyboard.mouseDown == true
        @playSound()

    deregister: ->
      super
      @getDisplayObj().off 'mouseover', @handleMouseOver

