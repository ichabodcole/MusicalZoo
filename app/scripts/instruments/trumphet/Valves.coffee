define ['InstrumentComponent',
        'Valve'], (InstrumentComponent, Valve)->

  class Valves extends InstrumentComponent
    constructor: (name, manifest)->
      super(name, manifest)

    addItem: (name, data, image)=>
        valve = new Valve(name, data, image)
        @addChild(valve)
        @items.push(valve)
