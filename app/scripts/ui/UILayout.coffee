define ['easel',
        'preload',
        'Icons',
        'Title',
        'Instruments',
        'Utils'], (createjs, Preload, Icons, Title, Instruments, Utils)->

  class UILayout extends createjs.Container
    constructor: (@manifest)->
      @initialize()
      @UIState = 0
      @title = null
      @icons = null
      @instruments = null

      @title = null
      @icons = null

      @components = manifest.ui.components

      @addComponents()
      createjs.EventDispatcher.initialize(@)
      @addEventListener("iconClick", @handleIconClick)

    addComponents: ()->
      titleManifest = @getComponentById('title')
      iconsManifest = @getComponentById('icons')

      @title = new Title(titleManifest)
      @icons = new Icons(iconsManifest)

      instrumentsManifest = @manifest.instruments
      @instruments = new Instruments(instrumentsManifest)

      @addChild(@title)
      @addChild(@icons)
      @addChild(@instruments)

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

    handleIconClick: (e)=>
      @instruments.setInstrument(e.target.link)
      if @UIState == 0
        @transitionUIToState1()
        @UIState = 1
      else
        @instruments.open()

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