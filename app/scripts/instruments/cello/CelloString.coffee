define ['easel', 'tween', 'ComponentItem'], (createjs, Tween, ComponentItem)->

  class CelloString extends ComponentItem
    constructor: (name, data)->
      super(name, data)
      @setup(data)
      @stringSound = createjs.Sound.play(@soundId)
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
      @off 'mouseover', @handleOnMouseOver
      @off 'mousedown', @handleOnMouseDown

    handleOnMouseOver: (e)=>
      if @parent.mouseDown == true
        @playSound()

    handleOnMouseDown: (e)=>
      @playSound()

    handlePressUp: (e)=>
      if @stringSound?
        transitionTime = 500
        endVolume = 0
        createjs.Tween.get(@stringSound, {override: true})
          .to({volume: endVolume}, transitionTime).call(@stopSound)

    stopSound: ()=>
      @stringSound.stop()

    playSound: (e)=>
      @stringSound.setPosition(0)
      @stringSound.play({loop: -1, volume: 0})
      transitionTime = 300
      endVolume = 1
      createjs.Tween.get(@stringSound, {override: true})
        .to({volume: endVolume}, transitionTime)
