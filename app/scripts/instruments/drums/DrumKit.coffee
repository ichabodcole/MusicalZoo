define ['Instrument',
        'DrumComponentFactory', 'Drums'], (Instrument, DrumComponentFactory, Drums)->

  class DrumKit extends Instrument
    constructor: (name, manifest)->
      super name, manifest

    addComponent: (component)=>
      id = component.id
      manifest = component
      drumComponent = DrumComponentFactory.create(id, manifest)
      drumComponent.load()
      @components.addChild(drumComponent)