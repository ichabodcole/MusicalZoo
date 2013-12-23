define ['easel',
        'preload',
        'tween',
        'InstrumentFactory'
        'Utils'], (createjs, Preload, Tween, InstrumentFactory, Utils)->

  class Instruments extends createjs.Container
    constructor: (@manifest)->
      @initialize()
      @queue = new createjs.LoadQueue(true)
      @currentInstrumentId
      @nextInstrumentId    = null
      @loadedInstruments = {
        drumKit: false,
        piano: false,
        cello: false
      }

    setInstrument: (id)->
      @nextInstrumentId = id

    open: ->
      # hide the previous instrument if any
      if @currentInstrumentId?
        @hideInstrument(@currentInstrumentId)

      # load the next instrument
      manifest = @getInstrumentManifestById(@nextInstrumentId)
      @loadInstrument(@nextInstrumentId, manifest)

      @currentInstrumentId = @nextInstrumentId

    getInstrumentManifestById: (id)->
      filtered = @manifest.filter (element, index)->
        return element.id == id
      return filtered[0]

    loadInstrument: (type, manifest)->
      if @loadedInstruments[type] == false
        instrument = InstrumentFactory.create(type, manifest)
        @loadedInstruments[type] = instrument
        @addInstrument(instrument)
      else
        instrument = @loadedInstruments[type]
        instrument.show()

    addInstrument: (instrument)->
      @addChild(instrument)
      instrument.load()

    hideInstrument: (id)->
      @loadedInstruments[id].hide()
