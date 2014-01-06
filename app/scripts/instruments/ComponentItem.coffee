define ['easel',
        'preload',
        'sound',
        'Utils'], (createjs, Preload, Sound, Utils)->

  class ComponentItem extends createjs.Container
    constructor: (name, data)->
      @initialize()
      @name    = name
      @sound   = null
      @soundId = @name + "_snd"

    setup: (data)->
      @setData(data)

    register: ->
      document.addEventListener 'keydown', @handleKeyDown, false

    deregister: ->
      document.removeEventListener 'keydown', @handleKeyDown, false

    handleKeyDown: (e)=>
      e.preventDefault()
      if e.which == @keyInput
        @playSound(e)

    playSound: (e)=>
      @sound = createjs.Sound.play(@soundId)
      @animate()

    stopSound: ()->
      if @sound?
        @sound.stop()

    animate: ->
      # Implement in child classes
      false

    setData: (data)->
      for key, dataItem of data
        @[key] = dataItem



