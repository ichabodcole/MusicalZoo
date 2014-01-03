define ['InstrumentComponent',
        'Drum', 'KickDrum'], (InstrumentComponent, Drum, KickDrum)->

  class Drums extends InstrumentComponent
    constructor: (name, manifest)->
      @kickDrum  = null
      @footPedal = null
      super(name, manifest)

    addItem: (name, data, image)=>
      if (name == 'kickDrum')
        @addKickDrum(name, data, image)
      else
        drum = new Drum(name, data, image)
        @addChild(drum)
        drum.register()
        @items.push(drum)

    addKickDrum: (name, data, image)->
      @kickDrum = new KickDrum(name, data, image)
      @addChild(@kickDrum)
      @kickDrum.register()
      @items.push(@kickDrum)
