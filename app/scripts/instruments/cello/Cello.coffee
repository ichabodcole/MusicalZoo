define ['Instrument', 'tween'], (Instrument, Tween)->

  class Cello extends Instrument
    constructor: (name, manifest)->
      super name, manifest
      @bow     = @getChildByName('bow')
      @strings = @getChildByName('strings')
      @stringsState = null
      @swapChildren(@bow, @strings)

    setup: =>
      super()
      @setEventHandlers()

    setEventHandlers: ->
      super()
      @on 'rollover', @handleMouseOver
      @on 'rollout', @handleMouseOut
      @on 'stringsPlaying', @handleStringPlaying
      @on 'stringsReady', @handleMouseOver

    handleMouseOver: (e)=>
      @strings.mouseOverCello = true
      unless @bow.state == @bow.READY
        @bow.gotoReadyState()

    handleMouseOut: (e)=>
      @strings.mouseOverCello = false
      @strings.clearTimer()
      unless @bow.state == @bow.DEFAULT
        @bow.gotoDefaultState()

    handleStringPlaying: (e)=>
      unless @bow.state == @bow.PLAYING
        @bow.gotoPlayState()
