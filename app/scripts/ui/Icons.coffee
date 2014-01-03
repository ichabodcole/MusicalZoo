define ['easel',
        'UIItem',
        'Icon',
        'Utils'], (createjs, UIItem, Icon, Utils)->

  class Icons extends UIItem
    constructor: (@manifest)->
      @icons     = []
      @drumIcon  = null
      @pianoIcon = null
      @celloIcon = null
      super(@manifest)

    setup: ->
      super()
      for iconData in @assets.images.manifest
        id    = iconData.id
        image = @queue.getResult(id)
        data  = @queue.getItem(id).data
        icon  = new Icon(id, image, data)
        @addChild(icon)

