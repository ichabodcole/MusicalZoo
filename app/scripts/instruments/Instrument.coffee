define ['easel',
        'preload',
        'tween',
        'sound'], (createjs, Preload, Tween, Sound)->

  class Instrument
    constructor: ()->
      @id = 'instrument'
      @container = new createjs.Container()
      @container.cursor = "pointer"
      @queue = new createjs.LoadQueue(true)
      @queue.installPlugin(createjs.Sound)
      @componentClass = null

      @assetManifest  = []
      @componentData  = []

      @getDisplayObj().visible = false
      createjs.EventDispatcher.initialize(@)

    # Interface methods

    parseManifest: (manifest)->

    load: (manifest)->
      @parseManifest(manifest)
      @queue.addEventListener('fileload', @handleFileLoad)
      @queue.addEventListener('complete', @loadComplete)
      @queue.loadManifest(@assetManifest)

    handleFileLoad: (e)=>

    loadComplete: (e)=>
      @setup()

    setup: =>
      @componentData.forEach (element, array, index)=>
        @addComponent(element).register()
      @show()

    tearDown: ->
      @componentData.forEach (element, array, index)=>
        @addComponent(element).deregister()

    addComponent: (data)->
      if @componentClass != null
        image = @getImage(data.id)
        data.image = image

        component = new @componentClass(data)
        @container.addChild(component.getDisplayObj())
        return component

    getImage: (imgId)->
      image = @queue.getResult(imgId + '_img')

    getDisplayObj: ->
      return @container

    show: ->
      ease = createjs.Ease.elasticOut
      transitionTime = 1500
      endScale = @scaleX

      obj = @getDisplayObj()
      obj.visible = true

      # setScale(0.1)
      obj.scaleX = obj.scaleY = 0.1
      createjs.Tween.get(obj).to({scaleX:endScale, scaleY:endScale}, transitionTime, ease)


    hide: ->
      ease = createjs.Ease.cubicIn
      transitionTime = 500
      endScale = 0.01

      obj = @getDisplayObj()

      # setScale(0.1)
      createjs.Tween.get(obj).to({scaleX:endScale, scaleY:endScale}, transitionTime, ease).call(@hideComplete)

    hideComplete: =>
      @getDisplayObj().visible = false
      @dispatchEvent(new Event('hideComplete'))

    setScale:(scale)->
      obj = @getDisplayObj()
      @scaleX = @scaleY = scale
      obj.scaleX = obj.scaleY = scale
      if @width && @height
        @width  *= scale
        @height *= scale


