define ['Instrument'], (Instrument)->

  class DrumKit extends Instrument
    constructor: (name, manifest)->
      super name, manifest