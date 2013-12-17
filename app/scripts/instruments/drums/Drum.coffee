define ['easel', 'sound', 'Instrument'], (creatjs, Sound, Instrument)->

  audioPath = 'sounds/drums/kit_01/'
  manifest = [{ id:'bassDrum', src: audioPath + 'Kick.wav' }]

  class Drum extends Instrument
    constructor: (imagePath, soundPath)->
      super

      @image = new createjs.Bitmap(imagePath)
      @drumSound = createjs.Sound.createInstance(soundPath)
      @container.drumSound = @drumSound
      @container.addEventListener 'click', @drumHit
      @container.addChild(@image)

    drumHit: (e)->
      drumSound = e.target.parent.drumSound
      drumSound.play()

    setPosition: (x, y)->
      obj = @getDisplayObj();
      obj.x = x
      obj.y = y