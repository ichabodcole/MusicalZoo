define ['easel',
        'preload',
        'tween',
        'Utils'], (createjs, Preload, Tween, Utils)->

  class Instrument extends createjs.Container
    constructor: (name, @manifest)->
      @initialize()
      @name = name
      @cursor = "pointer"
      @visible = false
      @components = []
      @assetManifests = null

      createjs.EventDispatcher.initialize(@)
      @setupLoadQueue()
      @parseManifest(@manifest)

    setupLoadQueue: ->
      @queue = new createjs.LoadQueue(false)
      @queue.addEventListener('fileload', @handleFileLoad)
      @queue.addEventListener('complete', @handleLoadComplete)

    parseManifest: (manifest)->
      if manifest.data
        @setData(manifest.data)

      if manifest.backgroundImage?
        path = manifest.backgroundImage.path
        src  = manifest.backgroundImage.src
        @queue.loadFile(src, false, path)

      if manifest.components?
        components = manifest.components
        @addComponents(components)

    load: ()->
      # @queue.load()
      @showProgressLoader()
      @handleLoadComplete()

    addComponents: (components)->
      components.forEach (element, index)=>
        @addComponent(element)

    addComponent: (component)=>
      # institute on child classes
      false

    addBackgroundImage: (image)->
      bitmap = new createjs.Bitmap(image)
      @addChild(bitmap)

    showProgressLoader: ->
      @loader = new createjs.Shape()
      @loader.graphics.beginFill("#ff0000").drawRect(0, 0, 250, 250)
      @addChild(@loader)

    handleFileLoad: (e, data)=>
      @addBackgroundImage(e.result, e.item.data)

    handleLoadComplete: (e)=>
      @setup()
      @loader.visible = false
      @show()

    setup: =>
      @setScale()
      stage = @getStage()
      Utils.centerOnStage(stage, @, @width)
      Utils.centerRegistration(@, @width, @height, true)

    setData: (data)->
      for key, dataItem of data
        @[key] = dataItem

    show: ->
      @visible = true
      ease = createjs.Ease.elasticOut
      transitionTime = 1500
      endScale = @scaleX

      # setScale(0.1)
      @scaleX = @scaleY = 0.1
      createjs.Tween.get(@).to({scaleX:endScale, scaleY:endScale}, transitionTime, ease)

    hide: ->
      ease = createjs.Ease.cubicIn
      transitionTime = 500
      endScale = 0.01

      # setScale(0.1)
      createjs.Tween.get(@).to({scaleX:endScale, scaleY:endScale}, transitionTime, ease).call(@hideComplete)

    hideComplete: =>
      @visible = false
      @dispatchEvent(new Event('hideComplete', true))

    setScale:(scale)->
      if @width && @height
        @width  *= @scaleX
        @height *= @scaleY
        console.log @width

    instrumentHideComplete: =>
      @show()

    instrumentShowComplete: ->


