define ['easel',
        'preload',
        'sound',
        'Utils'], (createjs, Preload, Sound, Utils)->

  class ComponentItem extends createjs.Container
    constructor: (name, data)->
      @initialize()
      @name  = name
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
      createjs.Sound.play(@soundId)
      @animate()

    animate: ->
      # Implement in child classes
      false

    setData: (data)->
      for key, dataItem of data
        @[key] = dataItem



