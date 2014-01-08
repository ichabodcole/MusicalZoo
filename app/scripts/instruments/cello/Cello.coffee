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
      @on 'rollover', @onMouseOver
      @on 'rollout', @onMouseOut
      @on 'stringsPlaying', @onStringPlaying
      @on 'stringsReady', @onMouseOver
      @on 'stringsDefault', @onStringsDefault

    onMouseOver: (e)=>
      @strings.mouseOverCello = true
      unless @bow.state == @bow.READY || @strings.keyCount > 0
        @bow.gotoReadyState()

    onMouseOut: (e)=>
      @strings.mouseOverCello = false
      @strings.clearTimer()
      unless @bow.state == @bow.DEFAULT || @strings.keyCount > 0
        @bow.gotoDefaultState()

    onStringPlaying: (e)=>
      unless @bow.state == @bow.PLAYING
        @bow.gotoPlayState()

    onStringsDefault: (e)=>
      unless @bow.state == @bow.DEFAULT
        @bow.gotoDefaultState()