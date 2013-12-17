define ['easel', 'sound', 'tween'], (creatjs, Sound, Tween)->

  audioPath = 'sounds/drums/kit_01/'
  manifest = [{ id:'bassDrum', src: audioPath + 'Kick.wav' }]

  class Drum
    constructor: (data)->
      @id     = data.id
      @image  = data.image
      @coords = data.coords

      @soundId = @id + "_snd"
      @container = new createjs.Container()
      # @container.cursor = "pointer"

      @bitmap = new createjs.Bitmap(@image)
      @setPosition(@coords.x, @coords.y)
      @setRegistration()

      @container.addEventListener 'click', @drumHit
      @container.addChild(@bitmap)

    drumHit: (e)=>
      obj = @getDisplayObj()
      obj.scaleX = .95
      obj.scaleY = .95

      setTimeout =>
        obj.scaleX = 1
        obj.scaleY = 1
      , 50

      # obj.scaleX += (1 - obj.scaleX)/2

      console.log("You hit the", @id)


      createjs.Sound.play(@soundId)

    setPosition: (x, y)->
      obj = @getDisplayObj();
      obj.x = x
      obj.y = y

    setRegistration: ()->
      obj = @getDisplayObj()
      obj.regX = @coords.width/2
      obj.regY = @coords.height/2

    getDisplayObj: ->
      return @container