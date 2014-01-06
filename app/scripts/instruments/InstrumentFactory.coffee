define ['DrumKit',
        'Piano',
        'Cello',
        'Trumphet'], (DrumKit, Piano, Cello, Trumphet)->

  class InstrumentFactory
    @types: {
      drumKit: DrumKit,
      piano: Piano,
      cello: Cello,
      trumphet: Trumphet
    }

    @create: (type, manifest)->
      if type
        new @types[type](type, manifest)
      else
        false

