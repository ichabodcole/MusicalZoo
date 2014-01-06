define ['UIItem'], (UIItem)->

  class KickPedal extends UIItem
    constructor: (manifest)->
      @upState   = null
      @downState = null
      super(manifest)

    setup: ->
      @upState   = @createBitmapFromResult(@queue, 'kickPedalUp')
      @downState = @createBitmapFromResult(@queue, 'kickPedalDown')
      # set the hit/down state image visiblily to false
      @downState.visible = false
      # compensate xpos for difference in image widths,
      # may want to move this to manifest file, or center images.
      @upState.x = 15

      @addChild(@upState, @downState)
      @setData(@data)

    animate: ->
      @upState.visible   = false
      @downState.visible = true
      setTimeout =>
        @upState.visible   = true
        @downState.visible = false
      , 100

