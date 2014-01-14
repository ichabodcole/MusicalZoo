define ["easel", "InstructionText","Utils"], (createjs, InstructionText ,Utils)->

  #TODO: create a common parent class for this and KeyboardOverlay
  class InstructionsOverlay extends createjs.Container

    # TODO: put text data in manifest file
    textData: [
      {
        id: "drumKitText",
        text: "Click on the drums with your left mouse button to play them."
      },
      {
        id: "pianoText",
        text: "Click or drag over the keys with your left mouse button to play the piano.",
      },
      {
        id: "celloText",
        text: "Hold your left mouse button down over the strings to play the cello."
      },
      {
        id: "trumpetText",
        text: "Click the mouth piece or the finger valves to play the trumpet."
      }
    ]

    constructor: ()->
      @initialize()
      @alpha   = 0
      @visible = 0
      @textYOffset = 200
      @instrumentTextId #set in setTextId()
      @textObjects = {}

    setup: ->
      @drawBackground()
      @addChild(@keysContainer)
      # create a text object for each instrument instruction text
      for obj in @textData
        id     = obj.id
        string = obj.text
        #
        iText = new InstructionText(string)
        iText.visible = 0
        textWidth = iText.getMeasuredWidth()
        iText.y = @textYOffset
        iText.x = ( window.MZ.stageWidth / 2 ) - ( textWidth / 2 )
        #
        @textObjects[id] = iText
        @addChild(iText)

    setInstrumentTextId: (instrumentId)->
      @instrumentTextId = instrumentId + "Text"

    drawBackground: ->
      @background = new createjs.Shape()
      @background.graphics.beginFill("#000000")
        .drawRect(0, 0, window.MZ.stageWidth, window.MZ.stageHeight)
      @background.alpha = 0.8
      #
      @addChild(@background)

    show: (instrumentId)->
      @setInstrumentTextId(instrumentId)
      @showText()
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

    showText: ()->
      @textObjects[@instrumentTextId].visible = true

    hideText: ()->
      @textObjects[@instrumentTextId].visible = false

    onHideComplete: =>
      @hideText()
      @visible = false
