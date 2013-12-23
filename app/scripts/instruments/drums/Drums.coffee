define ['InstrumentComponent',
        'Drum'], (InstrumentComponent, Drum)->

  class Drums extends InstrumentComponent
    constructor: (name, manifest)->
      super(name, manifest)

    addItem: (name, data, image)=>
      drum = new Drum(name, data, image)
      @addChild(drum)
      drum.register()
      @items.push(drum)
