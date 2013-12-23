define ['DrumKit',
        'Piano',
        'Cello'], (DrumKit, Piano, Cello)->

  class InstrumentFactory
    @types: {
      drumKit: DrumKit,
      piano: Piano,
      cello: Cello
    }

    @create: (type, manifest)->
      if type
        new @types[type](type, manifest)
      else
        false

