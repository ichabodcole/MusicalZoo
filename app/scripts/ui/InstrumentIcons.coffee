define ['easel',
        'UIItem',
        'InstrumentIcon',
        'Utils'], (createjs, UIItem, InstrumentIcon, Utils)->

  class InstrumentIcons extends UIItem
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
        icon  = new InstrumentIcon(id, image, data)
        @addChild(icon)

