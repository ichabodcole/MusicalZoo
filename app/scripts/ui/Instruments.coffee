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
      @nextInstrumentId     = null
      @loader               = null
      @lastInstrumentHidden = true

      @loadedInstruments = {
        drumKit: false,
        piano: false,
        cello: false
      }
      @setEventListeners()

    setInstrument: (id)->
      @nextInstrumentId = id

    setEventListeners: ->
      @on 'instrumentLoaded', @handleInstrumentLoaded
      @on 'instrumentHideComplete', @handleInstrumentHideComplete

    createLoader: ->
      loader = new createjs.Shape()
      loader.graphics.beginFill("#ff0000").drawCircle(0, 0, 50, 50)
      @addChild(loader)
      stage = @getStage()
      Utils.centerOnStage(stage, loader, 100, 100, false)
      loader.visible = false
      return loader

    showLoader: ->
      unless @loader?
        @loader = @createLoader()
      @loader.visible = true

    hideLoader: ->
      if @loader?
       @loader.visible = false

    open: ->
      # If the instrument is already open, don't try to reopen it.
      if @currentInstrumentId != @nextInstrumentId
        # hide the previous instrument if any
        if @currentInstrumentId?
          @lastInstrumentHidden = false
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
        instrument.load()

    addInstrument: (instrument)->
      @showLoader()
      @addChild(instrument)
      instrument.load()

    hideInstrument: (id)->
      @loadedInstruments[id].hide()

    handleInstrumentLoaded: (e)=>
      @hideLoader()
      # if previous intrument hide finished show new instrument
      if @lastInstrumentHidden == true
        @loadedInstruments[@currentInstrumentId].show()

    handleInstrumentHideComplete: (e)=>
      @lastInstrumentHidden = true
      # if instrument loaded call instrument loaded
      if @loadedInstruments[@currentInstrumentId].loaded == true
        @handleInstrumentLoaded()
