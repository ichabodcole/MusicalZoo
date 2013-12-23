define ['InstrumentComponent'], (InstrumentComponent)->

  class PianoKey extends InstrumentComponent
    constructor: (data, @keyboard)->
      super data
      @mouseEnabled = true

    register: ->
      super
      @on 'mouseover', @handleMouseOver

    handleMouseOver: =>
      if @keyboard.mouseDown == true
        @playSound()

    deregister: ->
      super
      @off 'mouseover', @handleMouseOver

