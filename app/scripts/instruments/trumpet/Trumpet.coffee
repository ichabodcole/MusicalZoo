define ['Instrument'], (Instrument)->

  class Trumpet extends Instrument
    constructor: (name, manifest)->
      super(name, manifest)
      @valves = @getChildByName('valves')
      @swapChildren(@valves, @backgroundImage)