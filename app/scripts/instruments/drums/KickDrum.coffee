define ['easel', 'sound' ,'Drum'], (createjs, Sound, Drum)->

  class BassDrum extends Drum
    constructor: ->
      imagePath = 'images/drums/bass_drum.png'
      soundPath = manifest[0].src

      super(imagePath, soundPath)

