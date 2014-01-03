define ['UIItem'], (UIItem)->

  class KickPedal extends UIItem
    constructor: (manifest)->
      @upState   = null
      @downState = null
      @timeout   = null
      super(manifest)

    setup: ->
      @upState   = @createBitmapFromResult(@queue, 'kickPedalUp')
      @downState = @createBitmapFromResult(@queue, 'kickPedalDown')
      @downState.visible = false
      @upState.x = 15
      @addChild(@upState, @downState)
      @setData(@data)

    animate: ->
      @upState.visible   = false
      @downState.visible = true
      window.clearTimeout(@timeout)
      @timeout = setTimeout =>
        @upState.visible   = true
        @downState.visible = false
      , 100

