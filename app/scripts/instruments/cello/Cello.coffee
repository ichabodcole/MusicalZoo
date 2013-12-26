define ['Instrument'], (Instrument)->

  class Cello extends Instrument
    constructor: (name, manifest)->
      super name, manifest