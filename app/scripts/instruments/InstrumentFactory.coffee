define ['DrumKit',
        'Piano',
        'Cello',
        'Trumpet'], (DrumKit, Piano, Cello, Trumpet)->

  class InstrumentFactory
    @types: {
      drumKit: DrumKit,
      piano: Piano,
      cello: Cello,
      trumpet: Trumpet
    }

    @create: (type, manifest)->
      if type
        new @types[type](type, manifest)
      else
        false

