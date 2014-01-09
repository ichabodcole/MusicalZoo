define ['easel',
        'preload',
        'tween',
        'InstrumentFactory'
        'Utils'], (createjs, Preload, Tween, InstrumentFactory, Utils)->

  class Instruments extends createjs.Container
    constructor: (@manifest, @preloader)->
      @initialize()
      @instrument # set in loadInstrument method
      @currentInstrumentId # set in open method
      @nextInstrumentId # set in setInstrument method
      @lastInstrumentHidden = true
      @queue = new createjs.LoadQueue(true)

      @showPreloaderEvent = new createjs.Event('showPreloader', true)
      @hidePreloaderEvent = new createjs.Event('hidePreloader', true)

      @loadedInstruments = {
        drumKit: false,
        piano: false,
        cello: false,
        trumpet: false
      }
      @setEventListeners()

    setInstrument: (id)->
      @nextInstrumentId = id

    setEventListeners: ->
      @on 'instrumentLoaded', @handleInstrumentLoaded
      @on 'instrumentHideComplete', @handleInstrumentHideComplete

    showPreloader: ->
      @dispatchEvent(@showPreloaderEvent)

    hidePreloader: ->
      @dispatchEvent(@hidePreloaderEvent)

    open: ->
      # If the instrument is already open, don't try to reopen it.
      if @currentInstrumentId != @nextInstrumentId
        if @currentInstrumentId?
          # unless a current item is in the process of loading
          if @checkLoadingInProgress() == false
          # hide the previous instrument if any
            @lastInstrumentHidden = false
            @hideInstrument(@currentInstrumentId)
          else
            # cancel the current loading item
            @cancelCurrentLoads()

        # load the next instrument
        manifest = @getInstrumentManifestById(@nextInstrumentId)
        @loadInstrument(@nextInstrumentId, manifest)

        @currentInstrumentId = @nextInstrumentId

    checkLoadingInProgress: ->
      if @instrument? && @instrument.loaded == false
        return true
      else
        return false

    cancelCurrentLoads: ->
      @preloader.reset()
      @lastInstrumentHidden = true
      @loadedInstruments[@currentInstrumentId] = false
      @instrument.cancelLoad()

    getInstrumentManifestById: (id)->
      filtered = @manifest.filter (element, index)->
        return element.id == id
      return filtered[0]

    loadInstrument: (type, manifest)->
      if @loadedInstruments[type] == false
        @instrument = InstrumentFactory.create(type, manifest)
        @preloadInstrument(@instrument)
        @addInstrument(@instrument)
      else
        @instrument = @loadedInstruments[type]
        @instrument.load()
        if @lastInstrumentHidden == true
          @hidePreloader()
          @instrument.show()

    preloadInstrument: (instrument)->
      @preloader.reset()
      qList = instrument.getQueueList()
      @preloader.addQueueList(qList)

    addInstrument: (instrument)->
      @showPreloader()
      @addChild(instrument)
      instrument.load()

    hideInstrument: (id)->
      @loadedInstruments[id].hide()

    handleInstrumentLoaded: (e)=>
      @hidePreloader()
      @loadedInstruments[@currentInstrumentId] = @instrument
      # if previous intrument hide finished show new instrument
      if @lastInstrumentHidden == true
        @loadedInstruments[@currentInstrumentId].show()

    handleInstrumentHideComplete: (e)=>
      @lastInstrumentHidden = true
      # if instrument loaded call instrument loaded
      unless @loadedInstruments[@currentInstrumentId] == false
        @handleInstrumentLoaded()
