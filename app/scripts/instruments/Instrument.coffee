define ['easel',
        'preload',
        'tween',
        'ComponentFactory',
        'InstrumentTitle',
        'Utils'], (createjs, Preload, Tween, ComponentFactory, InstrumentTitle, Utils)->

  class Instrument extends createjs.Container
    constructor: (name, @manifest)->
      @initialize()
      @scaleStart # set in setData
      @name               = name
      @visible            = false
      @components         = []
      @componentNumLoaded = 0
      @backgroundImage    = new createjs.Container()
      @queue              = new createjs.LoadQueue(false)
      @queueList          = [@queue]
      @loaded                = false
      @backgroundImageLoaded = false
      @componentsLoaded      = false

      @addChild(@backgroundImage)

      @instrumentLoadedEvent = new createjs.Event('instrumentLoaded', true)
      @instrumentHideEvent   = new createjs.Event('instrumentHideComplete', true)
      createjs.EventDispatcher.initialize(@)
      @setEventHandlers()
      @parseManifest(@manifest)

    setup: =>
      @instrumentTitle = new InstrumentTitle(@title)
      @addChild(@instrumentTitle)
      stage = @getStage()
      Utils.centerOnStage(stage, @, @width)
      Utils.centerRegistration(@, @width, @height, true)

    setEventHandlers: ->
      @on 'componentLoaded', @handleComponentLoadComplete
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
      qList = @getQueueList
      for q in qList
        q.removeAll()
      @loaded = @componentsLoaded = @backgroundImageLoaded = false
      @removeAllEventListeners('componentLoaded')
      @queue.removeAllEventListeners('fileload')
      @queue.removeAllEventListeners('complete')
      # not yet implemented
      # Should cancel any loading componets and clear any timers.
      # May need to remove this object from the loadedInstruments
      # object in the Instruments class.

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
      @queueList.push(component.queue)

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
      if @backgroundImageLoaded && @componentsLoaded then true else false

    dispatchLoadsComplete: ->
      @dispatchEvent(@instrumentLoadedEvent)
      @loaded = true

    setData: (data)->
      for key, dataItem of data
        @[key] = dataItem
      @scaleStart = @scaleX

    show: ->
      @instrumentTitle.show()
      @register()
      @visible = true
      ease = createjs.Ease.elasticOut
      transitionTime = 1500
      endScale = @scaleX
      @scaleX = @scaleY = 0.1
      createjs.Tween.get(@).to({scaleX:endScale, scaleY:endScale}, transitionTime, ease)

    hide: ->
      @instrumentTitle.hide()
      @deregister()
      ease = createjs.Ease.cubicIn
      transitionTime = 500
      endScale = 0.01
      createjs.Tween.get(@).to({scaleX:endScale, scaleY:endScale}, transitionTime, ease).call(@handleHideComplete)

    getQueueList: ->
      return @queueList

    handleBgImgFileLoad: (e, data)=>
      @addBackgroundImage(e.result, e.item.data)

    handleBgImgLoadComplete: (e)=>
      @backgroundImageLoaded = true
      if @checkAllLoadsComplete()
        @dispatchLoadsComplete()

    handleComponentLoadComplete: (e)=>
      @componentNumLoaded--
      if @componentNumLoaded == 0
        @componentsLoaded = true
        if @checkAllLoadsComplete()
          @dispatchLoadsComplete()

    handleHideComplete: ()=>
      @scaleX = @scaleY = @scaleStart
      @visible = false
      @dispatchEvent(@instrumentHideEvent)
