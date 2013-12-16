define ['easel', 'Instrument'], (createjs, Instrument)->
  class DrumKit
    constructor: (canvasObj)->
      @instrument = new Instrument()