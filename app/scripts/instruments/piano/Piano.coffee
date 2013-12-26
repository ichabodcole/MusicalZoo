define ['Instrument'], (Instrument)->

  class Piano extends Instrument
    constructor: (name, manifest)->
      super(name, manifest)