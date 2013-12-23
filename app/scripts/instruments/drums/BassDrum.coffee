define ['easel', 'sound' ,'Drum'], (createjs, Sound, Drum)->

  audioPath = 'sounds/drums/kit_01/'
  manifest = [{ id:'bassDrum', src: audioPath + 'Kick.wav' }]

  class BassDrum extends Drum
    constructor: ->
      imagePath = 'images/drums/bass_drum.png'
      soundPath = manifest[0].src

      super(imagePath, soundPath)
