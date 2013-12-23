define ['easel',
        'UIItem',
        'Icon',
        'Utils'], (createjs, UIItem, Icon, Utils)->

  class Icons extends UIItem
    constructor: (@manifest)->

      @width  = 603
      @height = 212
      @y      = 150

      @icons     = []
      @drumIcon  = null
      @pianoIcon = null
      @celloIcon = null
      super(@manifest)

    setup: ->
      super
      @setupIcons()

    setupIcons: ()->
      for iconData in @assets.images.manifest
        id    = iconData.id
        image = @queue.getResult(id)
        data  = @queue.getItem(id).data
        icon  = new Icon(id, image, data)
        @addChild(icon)

    setupIcon: (id, q, xPos)->
      iconData = q.getItem(id)
      icon     = @createBitmapFromResult(q, id)
      icon.x   = xPos
      width    = iconData.width
      height   = iconData.height
      Utils.centerRegistration(icon, width, height)
      @addChild(icon)

