define ['easel', 'sound' ,'Drum'], (createjs, Sound, Drum)->

  audioPath = 'sounds/drums/kit_01/'
  manifest = [{ id:'rideCymbal', src: audioPath + 'Ride_Cymbal.wav' }]

  class RideCymbal extends Drum
    constructor: ->
      imagePath = 'images/drums/ride_cymbal.png'
      soundPath = manifest[0].src

      super(imagePath, soundPath)
