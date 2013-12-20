define ['DrumKit',
        'Piano',
        'Cello'], (DrumKit, Piano, Cello)->

  class InstrumentFactory
    @types: {
      drums: DrumKit,
      piano: Piano,
      cello: Cello
    }

    @create: (type)->
      if type
        new @types[type]()
      else
        false

