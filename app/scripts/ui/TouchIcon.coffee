define ['easel'], (createjs)->

  class TouchIcon extends createjs.Container
    TEXT_DISABLED: "enable touch support"
    TEXT_ENABLED: "disable touch support"

    constructor: ->
      @initialize()
      @touchIcon
      @toggleState = false
      @alpha = 0.5
      @on 'mousedown', @onMouseDown
      @cursor = 'pointer'
      @iconSize = 10
      @iconTextSpacing = @iconSize / 2
      @disabledIcon = @createDisabledIcon()
      @enabledIcon = @createEnabledIcon()
      @enabledIcon.visible = false
      @text = @createText(@TEXT_DISABLED)
      @hitArea = @createHitArea()

      @addChild(@disabledIcon, @enabledIcon, @text)

    createHitArea: ()->
      width = (@iconSize * 2) + @iconTextSpacing + @text.getBounds().width
      hit = new createjs.Shape()
      hit.graphics.beginFill("#ff0000").drawRect(0, 0, width, @iconSize * 2)
      return hit

    createText: (string)->
      text = new createjs.Text(string, "17px "+ window.MZ.mainFont, "#ffffff")
      text.x = @iconSize * 2 + @iconTextSpacing
      return text

    createDisabledIcon: ->
      icon = new createjs.Shape()
      icon.graphics
        .setStrokeStyle(3)
        .beginStroke("#ffffff")
        .beginFill('#000000')
        .drawCircle(@iconSize, @iconSize, @iconSize)
      return icon

    createEnabledIcon: ->
      icon = new createjs.Shape()
      icon.graphics
        .setStrokeStyle(3)
        .beginFill('#ffffff')
        .drawCircle(@iconSize, @iconSize, @iconSize)
      return icon

    toggleIconVisible: ->
      @enabledIcon.visible  = !@enabledIcon.visible
      @disabledIcon.visible = !@disabledIcon.visible

    onMouseDown: (e)=>
      @toggleState = !@toggleState

      stage = @getStage()
      if @toggleState
        createjs.Touch.enable(stage)
        @toggleIconVisible()
        @text.text = @TEXT_ENABLED
        @alpha = 1
      else
        createjs.Touch.disable(stage)
        @toggleIconVisible()
        @text.text = @TEXT_DISABLED
        @alpha = 0.5
