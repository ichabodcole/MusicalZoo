define ['easel',
        'UIItem',
        'Utils'], (createjs, UIItem, Utils)->

  class Title extends UIItem
    constructor: (@manifest)->
      super(@manifest)
      data    = @manifest.assets.images.manifest[0].data

    setup: ->
      super()
      @title = @createBitmapFromResult(@queue, 'musicalZooTitle')
      @addChild(@title)
