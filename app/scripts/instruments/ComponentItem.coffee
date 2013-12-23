define ['easel',
        'preload',
        'sound',
        'Utils'], (createjs, Preload, Sound, Utils)->

  class ComponentItem extends createjs.Container
    constructor: (name, data, image)->
      @initialize()
      @name  = name
      @soundId = @name + "_snd"
      @setup(image, data)

    setup: (image, data)->
      @setData(data)
      @addImage(image)
      Utils.centerRegistration(@, @width, @height, true)

    addImage: (image)->
      bitmap = new createjs.Bitmap(image)
      @addChild(bitmap)

    register: ->
      @on 'click', @playSound
      document.addEventListener 'keydown', @handleKeyDown, false

    deregister: ->
      @off 'click', @playSound
      document.removeEventListener 'keydown', @handleKeyDown, false

    handleKeyDown: (e)=>
      e.preventDefault()
      console.log e.which
      console.log @keyInput
      if e.which == @keyInput
        @playSound(e)

    playSound: (e)=>
      console.log("You hit the", @id)
      console.log(@soundId)
      createjs.Sound.play(@soundId)
      @animate()

    animate: ->
      # Implement in child classes
      false

    setData: (data)->
      for key, dataItem of data
        @[key] = dataItem



