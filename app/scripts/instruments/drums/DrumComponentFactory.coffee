define ['Drums'], (Drums)->

  class DrumComponentFactory
    @types: {
      drums: Drums
    }

    @create: (type, manifest)->
      if type
        new @types[type](type, manifest)
      else
        false