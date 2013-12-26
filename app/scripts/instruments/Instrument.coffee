define ['easel',
        'preload',
        'tween',
        'ComponentFactory',
        'Utils'], (createjs, Preload, Tween, ComponentFactory, Utils)->

  class Instrument extends createjs.Container
    constructor: (name, @manifest)->
      @initialize()
      @name               = name
      @cursor             = "pointer"
      @visible            = false
      @scaleStart         = 1
      @assetManifests     = null
      @backgroundImage    = new createjs.Container()
      @components         = []
      @componentFactory   = null
      @componentNumLoaded = 0
      @loaded             = false

      @backgroundImageLoaded = false
      @componentsLoaded      = false

      @addChild(@backgroundImage)

      @instrumentLoadedEvent = new createjs.Event('instrumentLoaded', true)
      @instrumentHideEvent   = new createjs.Event('instrumentHideComplete', true)
      createjs.EventDispatcher.initialize(@)
      @setLoadQueue()
      @setEventHandlers()
      @parseManifest(@manifest)

    setup: =>
      @setScale()
      stage = @getStage()
      Utils.centerOnStage(stage, @, @width)
      Utils.centerRegistration(@, @width, @height, true)

    setEventHandlers: ->
      @on 'componentLoaded', @handleComponentLoadComplete

    setLoadQueue: ->
      @queue = new createjs.LoadQueue(false)
      @queue.addEventListener('fileload', @handleBgImgFileLoad)
      @queue.addEventListener('complete', @handleBgImgLoadComplete)

    parseManifest: (manifest)->
      if manifest.data
        @setData(manifest.data)

      if manifest.backgroundImage?
        path = manifest.backgroundImage.path
        src  = manifest.backgroundImage.src
        @queue.loadFile(src, false, path)
      else
        @bgImgLoadComplete

      if manifest.components?
        componentsData = manifest.components
        @addComponents(componentsData)

    load: ()->
      unless @checkAllLoadsComplete()
        @queue.load()
        @setup()

    cancelLoad: ->
      # not yet implemented
      # Should cancel any loading componets and clear any timers.
      # May need to remove this object from the loadedInstruments
      # object in the Instruments class.
      return false

    addComponents: (componentsData)->
      componentsData.forEach (componentData, index)=>
        @componentNumLoaded++
        @addComponent(componentData)

    addComponent: (componentData)=>
      id = componentData.id
      manifest = componentData
      component = ComponentFactory.create(id, manifest)
      @components.push(component)
      @addChild(component)
      component.load()
      component.register();

    register: ->
      @components.forEach (component, index)->
        component.register()

    deregister: ->
      @components.forEach (component, index)->
        component.deregister()

    addBackgroundImage: (image)->
      bitmap = new createjs.Bitmap(image)
      bitmap.name = "backgroundImage"
      @backgroundImage.addChild(bitmap)

    checkAllLoadsComplete:=>
      if @backgroundImageLoaded && @componentsLoaded
        @dispatchEvent(@instrumentLoadedEvent)
        @loaded = true
        return true
      return false

    setData: (data)->
      for key, dataItem of data
        @[key] = dataItem
      @scaleStart = @scaleX

    show: ->
      @register()
      @visible = true
      ease = createjs.Ease.elasticOut
      transitionTime = 1500
      endScale = @scaleX
      @scaleX = @scaleY = 0.1
      createjs.Tween.get(@).to({scaleX:endScale, scaleY:endScale}, transitionTime, ease)

    hide: ->
      @deregister()
      ease = createjs.Ease.cubicIn
      transitionTime = 500
      endScale = 0.01
      createjs.Tween.get(@).to({scaleX:endScale, scaleY:endScale}, transitionTime, ease).call(@handleHideComplete)

    setScale:(scale)->
      if @width && @height
        @width  *= @scaleX
        @height *= @scaleY

    handleBgImgFileLoad: (e, data)=>
      @addBackgroundImage(e.result, e.item.data)

    handleBgImgLoadComplete: (e)=>
      @backgroundImageLoaded = true
      @checkAllLoadsComplete()

    handleComponentLoadComplete: (e)=>
      @componentNumLoaded--
      if @componentNumLoaded == 0
        @componentsLoaded = true
      @checkAllLoadsComplete()

    handleHideComplete: ()=>
      @scaleX = @scaleY = @scaleStart
      @visible = false
      @dispatchEvent(@instrumentHideEvent)
