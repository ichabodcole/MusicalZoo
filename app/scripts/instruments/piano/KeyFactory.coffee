define ['TopKey', 'BottomKey'], (TopKey, BottomKey)->

  class PianoComponentItemFactory
    @types: {
      top: TopKey,
      bottom: BottomKey
    }

    @create: (type, name, data, image)->
      if type
        new @types[type](name, data, image)
      else
        false