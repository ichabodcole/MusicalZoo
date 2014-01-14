define ['easel',
        'preload',
        'Preloader'
        'KeyboardOverlay',
        'InstructionsOverlay',
        'InstructionsNav',
        'InstructionText',
        'Icons',
        'Title',
        'Instruments',
        'Utils']
        , (createjs
          ,Preload
          ,Preloader
          ,KeyboardOverlay
          ,InstructionsOverlay
          ,InstructionsNav
          ,InstructionText
          ,Icons
          ,Title
          ,Instruments
          ,Utils)->

  class UILayout extends createjs.Container
    constructor: (@manifest)->
      @initialize()
      @UIState = 0
      @title #set in addComponents
      @icons #set in addComponents
      @preloader #set in addComponents
      @instruments  #set in addComponents
      @instrumentId #set in onIconClick

      @components = manifest.ui.components

      @addComponents()
      createjs.EventDispatcher.initialize(@)
      @setEventListeners()

    setEventListeners: ->
      @on 'iconClick', @onIconClick
      @on 'showPreloader', @onShowPreloader
      @on 'hidePreloader', @onHidePreloader
      @on 'instructionsIconOver', @onInstructionsIconOver
      @on 'instructionsIconOut', @onInstructionsIconOut
      @on 'keyboardIconOver', @onKeyboardIconOver
      @on 'keyboardIconOut', @onKeyboardIconOut

    addComponents: ()->
      #TODO: automate the creation of these.
      titleManifest     = @getComponentById('title')
      iconsManifest     = @getComponentById('icons')
      preloaderManifest = @getComponentById('preloader')
      keyboardOverlayManifest = @getComponentById('keyboardOverlay')
      instructionsNavManifest = @getComponentById('instructionsNav')

      @title     = new Title(titleManifest)
      @icons     = new Icons(iconsManifest)
      @preloader = new Preloader(preloaderManifest)
      @keyboardOverlay = new KeyboardOverlay(keyboardOverlayManifest)
      @instructionsOverlay = new InstructionsOverlay()
      @instructionsNav = new InstructionsNav(instructionsNavManifest)

      instrumentsManifest = @manifest.instruments
      @instruments = new Instruments(instrumentsManifest, @preloader)
      @addChild(@instruments)

      # create the intro instructional text and center it.
      @introText = new InstructionText("( Select an instrument to begin )", 0, 400)
      @introText.x = (window.MZ.stageWidth / 2) - (@introText.getMeasuredWidth() / 2)

      @addChild(@title)
      @addChild(@icons)
      @addChild(@preloader)
      @addChild(@keyboardOverlay)
      @addChild(@instructionsOverlay)
      @addChild(@instructionsNav)
      @addChild(@introText)

      @instructionsOverlay.setup()


    getComponentById: (id)->
      filtered = @components.filter (element)->
        return element.id == id
      return filtered[0]

    transitionUIToState1: ->
      transitionTime = 1000
      easing         = createjs.Ease.cubicOut
      titleEndY      = @title.y - 50
      introTextEnd   = 0
      iconsEndY      = 550
      iconsEndScale  = 0.45
      iconsEndAlpha  = 0.5
      # move the title up a little
      createjs.Tween.get(@title)
        .to({y:titleEndY}, transitionTime, easing)

      # fade out the intro instruction text in half the time of everything else
      createjs.Tween.get(@introText)
        .to({alpha: introTextEnd}, transitionTime / 2, easing)

      # move and scale the icons down
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
      @removeChild(@introText)
      @instruments.open()
      @showInstructionsNav()

    showInstructionsNav: ->
      @instructionsNav.alpha = 0
      @instructionsNav.visible = true
      #
      transitionTime = 1000
      easing         = createjs.Ease.cubicOut
      endAlpha       = 1
      createjs.Tween.get(@instructionsNav)
        .wait(1000)
        .to({alpha:endAlpha}, transitionTime, easing)

    onIconClick: (e)=>
      @instrumentId = e.target.link
      @instruments.setInstrument(@instrumentId)
      if @UIState == 0
        @transitionUIToState1()
        @UIState = 1
      else
        @instruments.open()

    onInstructionsIconOver: (e)=>
      @instructionsOverlay.show(@instrumentId)

    onInstructionsIconOut: (e)=>
      @instructionsOverlay.hide()

    onKeyboardIconOver: (e)=>
      @keyboardOverlay.show(@instrumentId)

    onKeyboardIconOut: (e)=>
      @keyboardOverlay.hide()

    onShowPreloader: =>
      @preloader.show()

    onHidePreloader: =>
      @preloader.hide()