define ['easel',
        'sound'], (createjs, Sound)->
  class InstrumentComponent
    constructor: (data)->
      @container = new createjs.Container()
      @id       = data.id
      @image    = data.image
      @coords   = data.coords
      @keyInput = data.keyInput
      # console.log data
      @soundId = @id + "_snd"
      @container = new createjs.Container()
      @setup()

    setup: ->
      bitmap = new createjs.Bitmap(@image)
      @setPosition(@coords.x, @coords.y)
      @getDisplayObj().addChild(bitmap)

    register: ->
      @container.on 'click', @playSound, false
      document.addEventListener 'keydown', @handleKeyDown, false

    deregister: ->
      @container.off 'click', @playSound, false
      document.removeEventListener 'keydown', @handleKeyDown, false

    handleKeyDown: (e)=>
      e.preventDefault()
      console.log e.which
      if e.which == @keyInput
       @playSound(e)

    playSound: (e)=>
      # console.log("You hit the", @id)
      createjs.Sound.play(@soundId)
      @animate()

    animate: ->
      # Implement in child classes

    setPosition: (x, y)->
      obj = @getDisplayObj();
      obj.x = x
      obj.y = y

    setRegistrationCenter: ()->
      obj = @getDisplayObj()
      obj.regX = @coords.width/2
      obj.regY = @coords.height/2

    getDisplayObj: ->
      return @container