define ['Keyboard'], (Keyboard)->

  class PianoComponentFactory
    @types: {
      keyboard: Keyboard
    }

    @create: (type, manifest)->
      if type
        new @types[type](type, manifest)
      else
        false