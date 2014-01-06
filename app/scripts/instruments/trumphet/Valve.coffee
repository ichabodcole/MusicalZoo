define ['easel', 'ComponentItem'], (createjs, ComponentItem)->

  class Valve extends ComponentItem
    constructor: (name, data, image)->
      super(name, data)
      @setup(data, image)

    setup: (data, image)->
      super(data)
      @addImage(image)

    addImage: (image)->
      @bgImage = new createjs.Bitmap(image)
      @addChild(@bgImage)

    register: ->
      super()
      @on('mousedown', @onMouseDown)
      @on('pressup', @onPressUp)
      document.addEventListener('keyup', @onKeyUp, false)

    deregister: ->
      super()
      @removeAllEventListeners('mousedown')
      @removeAllEventListeners('pressup')
      document.removeEventListener('keyup', @onKeyUp, false)

    onKeyUp: (e)=>
      e.preventDefault()
      if e.which == @keyInput
        @fadeOutSound()

    onMouseDown: (e)->
      @playSound()
      @animate()

    onPressUp: (e)=>
      @fadeOutSound()
      @animate(false)

    playSound: (e)=>
      @sound = createjs.Sound.play(@soundId, {loop: -1, volume: 0})
      transitionTime = 300
      endVolume = 1
      createjs.Tween.get(@sound, {override: true})
        .to({volume: endVolume}, transitionTime)

    fadeOutSound: (e)->
      if @sound?
        transitionTime = 400
        endVolume = 0
        createjs.Tween.get(@sound, {override: true})
          .to({volume: endVolume}, transitionTime).call(@stopSound)

    animate: (state)->
      if state == false
        @y -= 15
      else
        @y += 15