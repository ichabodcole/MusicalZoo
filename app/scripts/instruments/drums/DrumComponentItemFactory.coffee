define ['Drum'], (Drum)->

  class DrumComponentItemFactory
    @types: {
      Drum: Drum
    }

    @create: (type, name, data, image)->
      if type
        new @types[type](name, data, image)
      else
        false