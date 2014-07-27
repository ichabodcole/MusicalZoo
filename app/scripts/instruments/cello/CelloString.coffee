define ['easel', 'tween', 'ComponentItem'], (createjs, Tween, ComponentItem)->

  class CelloString extends ComponentItem
    constructor: (name, data)->
      super(name, data)
      @setup(data)
      @soundTween  = null
      # @stringSound.pause()


    setup: (data)->
      super(data)
      @addHitArea(data)

    addHitArea: (data)->
      hit = new createjs.Shape()
      hit.graphics.beginFill('#ffffff')
         .drawEllipse(data.x, data.y, data.width, data.height)
      # @hitArea = hit
      @addChild(hit)

    register: ->
      super()
      @on 'mouseover', @onMouseOver
      @on 'mousedown', @onMouseDown
      @on 'pressup', @onPressUp
      @on 'mouseout', @onPressUp


    deregister: ->
      super()
      @removeAllEventListeners('mouseover')
      @removeAllEventListeners('mousedown')
      @removeAllEventListeners('pressup')
      @removeAllEventListeners('mouseout')

    onMouseOver: (e)=>
      if @parent.mouseDown == true
        @playSound()

    onMouseDown: (e)=>
      @playSound()

    onPressUp: (e)=>
      @fadeOutSound()

    onKeyDown: (e)=>
      # console.log "You pressed the key:", e.which
      e.preventDefault()
      unless @keyDownFired
        if e.which == @keyInput
          @parent.keyCount++
          @playSound(e)
          @keyDownFired = true
          @parent.dispatchEvent(@parent.stringsPlayingEvent)

    onKeyUp: (e)=>
      super(e)
      if e.which == @keyInput
        @fadeOutSound()
        @parent.keyCount--
        if @parent.mouseDown == false && @parent.keyCount == 0
          @parent.dispatchEvent(@parent.stringsDefaultEvent)

    fadeOutSound: ->
      if @sound?
        transitionTime = 500
        endVolume = 0
        createjs.Tween.get(@sound, {override: true})
          .to({volume: endVolume}, transitionTime).call(@stopSound)

    playSound: (e)=>
      @sound = createjs.Sound.play(@soundId, {loop: -1, volume: 0})
      transitionTime = 300
      endVolume = 1
      createjs.Tween.get(@sound, {override: true})
        .to({volume: endVolume}, transitionTime)
