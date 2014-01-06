define ['Keyboard',
        'Drums',
        'CelloStrings',
        'Bow',
        'Valves'], (Keyboard, Drums, CelloStrings, Bow, Valves)->

  class ComponentFactory
    @types: {
      drums: Drums
      keyboard: Keyboard
      strings: CelloStrings
      bow: Bow,
      valves: Valves
    }

    @create: (type, manifest)->
      if type
        new @types[type](type, manifest)
      else
        false