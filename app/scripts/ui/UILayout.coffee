define ['easel',
        'preload',
        'Preloader'
        'Icons',
        'Title',
        'Instruments',
        'Utils'], (createjs, Preload, Preloader, Icons, Title, Instruments, Utils)->

  class UILayout extends createjs.Container
    constructor: (@manifest)->
      @initialize()
      @UIState = 0
      @title = null
      @icons = null
      @instruments = null

      @title = null
      @icons = null
      @preloader = null

      @components = manifest.ui.components

      @addComponents()
      createjs.EventDispatcher.initialize(@)
      @setEventListeners()

    setEventListeners: ->
      @on 'iconClick', @onIconClick
      @on 'showPreloader', @onShowPreloader
      @on 'hidePreloader', @onHidePreloader

    addComponents: ()->
      titleManifest = @getComponentById('title')
      iconsManifest = @getComponentById('icons')
      preloaderManifest = @getComponentById('preloader')

      @title = new Title(titleManifest)
      @icons = new Icons(iconsManifest)
      @preloader = new Preloader(preloaderManifest)

      instrumentsManifest = @manifest.instruments
      @instruments = new Instruments(instrumentsManifest, @preloader)

      @addChild(@title)
      @addChild(@icons)
      @addChild(@instruments)
      @addChild(@preloader)

    getComponentById: (id)->
      filtered = @components.filter (element)->
        return element.id == id
      return filtered[0]

    loadManifest: (manifest)->
      @queue.addEventListener('complete', @onManifestLoad)
      @queue.loadManifest(manifest)

    onManifestLoad: (e)=>
      @title = new Title(@queue)
      @icons = new Icons(@queue, @)

      @stage.addChild(@title)
      @stage.addChild(@icons)

    transitionUIToState1: ->
      transitionTime = 1000
      easing         = createjs.Ease.cubicOut
      titleEndY      = @title.y - 50
      iconsEndY      = 550
      iconsEndScale  = 0.45
      iconsEndAlpha  = 0.5

      createjs.Tween.get(@title).to({y:titleEndY}, transitionTime, easing)
      createjs.Tween.get(@icons)
        .to({
              y: iconsEndY,
              scaleX: iconsEndScale,
              scaleY: iconsEndScale,
              alpha: iconsEndAlpha
            },
            transitionTime, easing)
        .call(@UITransitionComplete)

    UITransitionComplete: (e)=>
      @instruments.open()

    onIconClick: (e)=>
      @instruments.setInstrument(e.target.link)
      if @UIState == 0
        @transitionUIToState1()
        @UIState = 1
      else
        @instruments.open()

    onShowPreloader: =>
      @preloader.show()

    onHidePreloader: =>
      @preloader.hide()