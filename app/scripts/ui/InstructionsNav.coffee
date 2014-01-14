define ["UIItem"], (UIItem)->

  class InstructionsNav extends UIItem
    constructor: (manifest)->
      @instructionsIcon
      @keyboardIcon
      @keyboardIconOver = new createjs.Event('keyboardIconOver', true)
      @keyboardIconOut  = new createjs.Event('keyboardIconOut', true)
      @instructionsIconOver = new createjs.Event('instructionsIconOver', true)
      @instructionsIconOut  = new createjs.Event('instructionsIconOut', true)
      createjs.EventDispatcher.initialize(@)
      super(manifest)
      @visible = false

    setup: ->
      @setData(@data)
      @instructionsIcon = @createBitmapFromResult(@queue, 'instructionsIcon')
      @keyboardIcon     = @createBitmapFromResult(@queue, 'keyboardIcon')

      @addChild(@instructionsIcon)
      @addChild(@keyboardIcon)

      @keyboardIcon.x = 60
      @keyboardIcon.cursor = 'pointer'
      @keyboardIcon.on 'mouseover', @onKeyboardMouseOver
      @keyboardIcon.on 'mouseout', @onKeyboardMouseOut

      @instructionsIcon.cursor = 'pointer'
      @instructionsIcon.on 'mouseover', @onInstructionsOver
      @instructionsIcon.on 'mouseout', @onInstructionsOut

    onKeyboardMouseOver: (e)=>
      @dispatchEvent(@keyboardIconOver)

    onKeyboardMouseOut: (e)=>
      @dispatchEvent(@keyboardIconOut)

    onInstructionsOver: (e)=>
      @dispatchEvent(@instructionsIconOver)

    onInstructionsOut: (e)=>
      @dispatchEvent(@instructionsIconOut)
