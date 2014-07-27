define ["UIItem", "Utils"], (UIItem, Utils)->

  class KeyboardOverlay extends UIItem
    constructor: (manifest)->
      super(manifest)
      @alpha   = 0
      @visible = 0
      @keysets = {} #set in setup()
      @keysContainer #set in setup()
      @keysetId #set in setKeysetId()
      @imageManifest = @assets.images.manifest

    setup: ->
      @drawBackground()
      @keysContainer = new createjs.Container()
      @keysContainer.y = 150
      @addChild(@keysContainer)
      # create bitmap objects for each of the keysets
      for keyset in @imageManifest
        id = keyset.id
        image = @keysets[id] = @setUpImageFromResult(id)
        if id == 'keyboard'
          @keysContainer.setChildIndex(image, 0)
        else
          image.visible = false
      super()

    setKeysetId: (instrumentId)->
      @keysetId = instrumentId + "Keys"

    centerKeysContainer: ->
      keyboardBounds = @keysContainer.getChildByName('keyboard').getBounds()
      width = keyboardBounds.width
      stage = @getStage()
      Utils.centerOnStage(stage, @keysContainer, width)

    drawBackground: ->
      @background = new createjs.Shape()
      @background.graphics.beginFill("#000000")
        .drawRect(0, 0, window.MZ.stageWidth, window.MZ.stageHeight)
      @background.alpha = 0.8
      #
      @addChild(@background)

    show: (instrumentId)->
      @setKeysetId(instrumentId)
      @showKeyset()
      @centerKeysContainer()
      ease = createjs.Ease.cubicInOut
      endAlpha = 1
      @visible = true
      createjs.Tween.get(@, {override: true})
        .to({alpha: endAlpha}, 300, ease)

    hide: ->
      ease = createjs.Ease.cubicInOut
      endAlpha = 0
      createjs.Tween.get(@, {override: true})
        .to({alpha: endAlpha}, 300, ease).call(@onHideComplete)

    showKeyset: ()->
      # console.log @keysetId
      @keysets[@keysetId].visible = true

    hideKeyset: ()->
      @keysets[@keysetId].visible = false

    onHideComplete: =>
      @hideKeyset()
      @visible = false

    setUpImageFromResult: (id)->
      item = @queue.getItem(id)
      data = item.data
      image = @createBitmapFromResult(@queue, id)
      # set the properties of this image taken from the data attribute
      for key, value of data
        image[key] = value
      @keysContainer.addChild(image)
