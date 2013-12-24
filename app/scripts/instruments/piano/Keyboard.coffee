define ['InstrumentComponent',
        'KeyFactory'], (InstrumentComponent, KeyFactory)->

  class Keyboard extends InstrumentComponent
    constructor: (name, manifest)->
      super(name, manifest)

    addItem: (name, data, image)=>
      type = data.type
      key = KeyFactory.create(type, name, data, image)
      @addChild(key)
      key.register()