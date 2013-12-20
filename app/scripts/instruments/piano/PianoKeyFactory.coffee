define ['PianoBottomKey',
        'PianoTopKey'], (PianoBottomKey, PianoTopKey)->

  class InstrumentFactory
    @types: {
      bottom: PianoBottomKey,
      top: PianoTopKey
    }

    @create: (type, data, keyboard)->
      if type
        new @types[type](data, keyboard)
      else
        false