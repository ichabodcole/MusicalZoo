define ["easel", "InstructionText", "Utils"], (createjs, InstructionText, Utils)->

  class InstrumentTitle extends createjs.Container

    constructor: (data)->
      @initialize()
      @alpha = 0
      @visible = 0
      @data = data
      @setup(data)

    setup: (data)->
      string = data.text
      #
      @iText = new InstructionText(string, 0, 0, 500)
      textWidth = @iText.getBounds().width
      @iText.y = data.y
      @iText.x = data.x
      #
      @addChild(@iText)

    show: ()->
      ease = createjs.Ease.cubicInOut
      endAlpha = 1
      @visible = true
      @y = -20
      endY = 0
      createjs.Tween.get(@, {override: true})
        .wait(250)
        .to({alpha: endAlpha, y: endY}, 500, ease)

    hide: ->
      ease = createjs.Ease.cubicInOut
      endAlpha = 0
      createjs.Tween.get(@, {override: true})
        .to({alpha: endAlpha}, 300, ease).call(@onHideComplete)

    onHideComplete: =>
      @visible = false
