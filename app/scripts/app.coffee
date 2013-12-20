define ['easel',
        'preload',
        'tween',
        'InstrumentFactory',
        'IconLayout',
        'Title'
        'Utils'], (createjs, Preload, Tween, InstrumentFactory, IconLayout, Title, Utils)->

  class App
    constructor: ->
      @stage               = new createjs.Stage('musicalzoo-stage');
      @stageWidth          = @stage.canvas.width
      @stageHeight         = @stage.canvas.height
      @queue               = new createjs.LoadQueue(true)

      @instrumentsManifest = null
      @layoutManifest      = null
      @currentInstrumentId = null
      @nextInstrumentId    = null


      @iconLayout          = null
      @layoutState         = 0

      createjs.EventDispatcher.initialize(@)
      @stage.enableMouseOver(55)
      @setupEventListeners()
      @loadMainManifest()

      @instrumentFactory = {
        drumsIconClick: "drums",
        pianoIconClick: "piano",
        celloIconClick: "cello"
      }

      @loadedInstruments = {
        drums: false,
        piano: false,
        cello: false
      }

    setupEventListeners: ->
      @addEventListener 'drumsIconClick', @handleIconClick
      @addEventListener 'pianoIconClick', @handleIconClick
      @addEventListener 'celloIconClick', @handleIconClick

    handleIconClick: (e)=>
      @nextInstrumentId = @instrumentFactory[e.type]

      if @layoutState == 0
        @transitionLayoutToState1()
        @layoutState = 1
      else if @currentInstrumentId != null
        @loadedInstruments[@currentInstrumentId].hide()

      @currentInstrumentId = @nextInstrumentId

    transitionLayoutToState1: ->
      transitionTime = 1000
      easing = createjs.Ease.cubicInOut

      titleEndY = 10
      createjs.Tween.get(@title).to({y:titleEndY}, transitionTime, easing)

      iconLayoutEndY     = 550
      iconLayoutEndScale = 0.45
      iconLayoutEndAlpha = 0.5
      createjs.Tween.get(@iconLayout)
        .to({
              y: iconLayoutEndY,
              scaleX: iconLayoutEndScale,
              scaleY: iconLayoutEndScale,
              alpha: iconLayoutEndAlpha
            },
            transitionTime, createjs.Ease.cubicInOut)
        .call(@layoutTransitionComplete)

    removeInstrument: ->

    layoutTransitionComplete: (e)=>
      @loadInstrument(@nextInstrumentId, @instrumentsManifest[@nextInstrumentId])

    loadMainManifest: ->
      @queue.addEventListener('fileload', @onManifestLoad)
      @queue.loadFile({src:'./musicalzoo_manifest.json', id:'manifest'})

    # Fat arrow for maintaining correct scope
    onManifestLoad: (e)=>
      @manifest = @queue.getResult('manifest')
      @instrumentsManifest = @manifest.instruments
      @layoutManifest = @manifest.layout

      # Remove the initial event listener
      @queue.removeEventListener('fileload', @onManifestLoad)
      @queue.reset()
      @doLayout(@layoutManifest)

    doLayout: (layoutManifest)->
      @queue.addEventListener('complete', @onLayoutLoadComplete)
      @queue.loadManifest(@layoutManifest)

    onLayoutLoadComplete: (e)=>
      @title = new Title(@queue)
      @iconLayout = new IconLayout(@queue, @)

      @title.y = 50
      @iconLayout.y = 150

      Utils.centerOnStage(@stage, @title, 220)
      Utils.centerOnStage(@stage, @iconLayout, @iconLayout.width)
      Utils.centerRegistration(@iconLayout, @iconLayout.width, @iconLayout.height)

      @stage.addChild(@title)
      @stage.addChild(@iconLayout)

    loadInstrument: (type, manifest)->
      if @loadedInstruments[type] == false
        instrument = InstrumentFactory.create(type)
        @loadedInstruments[type] = instrument
        @addInstrument instrument, manifest
        instrument.addEventListener('hideComplete', @instrumentHideComplete)
      else
        instrument = @loadedInstruments[type]
        instrument.show()

    addInstrument: (instrument, manifest)->
      width = manifest.width
      obj = instrument.getDisplayObj()

      Utils.centerOnStage(@stage, obj, instrument.width)
      Utils.centerRegistration(obj, instrument.width, instrument.height, true)

      if @nextInstrumentId == "drums"
        obj.y += 35
        obj.x -= 15
        instrument.setScale(0.95)
      else if @nextInstrumentId == "piano"
        obj.y += 5
        instrument.setScale(0.75)

      @stage.addChild(obj)
      # #
      instrument.load(manifest)

    instrumentHideComplete: =>
      @loadInstrument(@nextInstrumentId, @instrumentsManifest[@nextInstrumentId])

    instrumentShowComplete: ->

  createjs.EventDispatcher.initialize(App.prototype)

  app = new App();
  createjs.Ticker.addEventListener('tick', app.stage)

  console.log Utils.makePianoKeyJson()



