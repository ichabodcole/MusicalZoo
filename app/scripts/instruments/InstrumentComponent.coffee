define ['easel',
        'preload',
        'tween',
        'sound',
        'Utils'], (createjs, Preload, Tween, Sound, Utils)->

  class InstrumentComponent extends createjs.Container
    constructor: (name, @manifest)->
      @initialize()
      @name    = name
      @cursor  = "pointer"
      @visible = false
      @items   = []
      @assetManifests = null

      createjs.EventDispatcher.initialize(@)
      @componentLoadedEvent = new createjs.Event('componentLoaded', true)
      @setupLoadQueue()
      @parseManifest(@manifest)

    setupLoadQueue: ->
      @queue = new createjs.LoadQueue(false)
      @queue.installPlugin(createjs.Sound)
      @queue.addEventListener('fileload', @handleFileLoad)
      @queue.addEventListener('complete', @handleLoadComplete)

    parseManifest: (manifest)->
      if manifest.data?
        @setData(manifest.data)

      if manifest.assets?
        if manifest.assets.images?
          @queue.loadManifest(manifest.assets.images)

        if manifest.assets.sounds?
           @queue.loadManifest(manifest.assets.sounds)

    load: ()->
      @queue.load()

    addItem: (name, data, image)=>
      # Institute on child class
      false

    register: ->
      @items.forEach (item, index)->
        item.register()

    deregister: ->
      @items.forEach (item, index)->
        item.deregister()

    handleFileLoad: (e)=>
      if e.item.type == "image"
        name = e.item.id
        data = e.item.data
        image = e.result
        @addItem(name, data, image)

    handleLoadComplete: (e)=>
      @setup()
      @visible = true
      @dispatchEvent(@componentLoadedEvent)

    setup: ->
      false

    setData: (data)->
      for key, dataItem of data
        @[key] = dataItem


