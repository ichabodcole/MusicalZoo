define ['Keyboard', 'Drums', 'CelloStrings', 'Bow'], (Keyboard, Drums, CelloStrings, Bow)->

  class ComponentFactory
    @types: {
      drums: Drums
      keyboard: Keyboard
      strings: CelloStrings
      bow: Bow
    }

    @create: (type, manifest)->
      if type
        new @types[type](type, manifest)
      else
        false