define ['easel',
        'preload',
        'sound',
        'Utils'], (createjs, Preload, Sound, Utils)->

  class ComponentItem extends createjs.Container
    constructor: (name, data)->
      @initialize()
      @name    = name
      @soundId = @name + "_snd"
      @sound #set in playSound method
      @keyDownFired #set in register method

    setup: (data)->
      @setData(data)

    register: ->
      @keyDownFired = false
      document.addEventListener 'keydown', @onKeyDown, false
      document.addEventListener 'keyup', @onKeyUp, false

    deregister: ->
      document.removeEventListener 'keydown', @onKeyDown, false
      document.removeEventListener 'keyup', @onKeyUp, false

    onKeyDown: (e)=>
      console.log "You pressed the key:", e.which
      e.preventDefault()
      unless @keyDownFired
        if e.which == @keyInput
          @playSound(e)
          @keyDownFired = true

    onKeyUp: (e)=>
      if e.which == @keyInput
        @keyDownFired = false

    playSound: ()->
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



