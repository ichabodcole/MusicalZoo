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
      hit.graphics.beginFill('#00ADEE')
         .drawEllipse(data.x, data.y, data.width, data.height)
      # @hitArea = hit
      @addChild(hit)

    register: ->
      super()
      @on 'mouseover', @handleOnMouseOver
      @on 'mousedown', @handleOnMouseDown
      @on 'pressup', @handlePressUp
      @on 'mouseout', @handlePressUp


    deregister: ->
      super()
      @removeAllEventListeners('mouseover')
      @removeAllEventListeners('mousedown')
      @removeAllEventListeners('pressup')
      @removeAllEventListeners('mouseout')

    handleOnMouseOver: (e)=>
      if @parent.mouseDown == true
        @playSound()

    handleOnMouseDown: (e)=>
      @playSound()

    handlePressUp: (e)=>
      @fadeOutSound()

    onKeyUp: (e)=>
      super(e)
      if e.which == @keyInput
        @fadeOutSound()

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
