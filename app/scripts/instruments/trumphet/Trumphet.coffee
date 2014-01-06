define ['Instrument'], (Instrument)->

  class Trumphet extends Instrument
    constructor: (name, manifest)->
      super(name, manifest)
      @valves = @getChildByName('valves')
      @swapChildren(@valves, @backgroundImage)