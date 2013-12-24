define ['Instrument',
        'PianoComponentFactory'], (Instrument, PianoComponentFactory)->

  class Piano extends Instrument
    constructor: (name, manifest)->
      super(name, manifest)
      # @topKeys    = new createjs.Container()
      # @bottomKeys = new createjs.Container()
      # @keyboard.mouseDown = false

      # @addChild(@keyboard)
      # @keyboard.addChild(@bottomKeys)
      # @keyboard.addChild(@topKeys)

    addComponent: (component)=>
      id = component.id
      manifest = component
      pianoComponent = PianoComponentFactory.create(id, manifest)
      pianoComponent.register()
      @components.addChild(pianoComponent)
      pianoComponent.load()