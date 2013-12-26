define ['Keyboard', 'Drums'], (Keyboard, Drums)->

  class ComponentFactory
    @types: {
      drums: Drums
      keyboard: Keyboard
    }

    @create: (type, manifest)->
      if type
        new @types[type](type, manifest)
      else
        false