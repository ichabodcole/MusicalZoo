define ['easel',
        'preload',
        'sound',
        'Utils'], (createjs, Preload, Sound, Utils)->

  class UIItem extends createjs.Container

    constructor: (@manifest)->
      @initialize()
      @queue  = new createjs.LoadQueue(false)
      @assets = @manifest.assets
      @loadManifest(@manifest)

    loadManifest: (manifest)->
      @queue.addEventListener('complete', @onLoadComplete)
      @queue.loadManifest(@assets.images)
      if @assets.sounds?
        @queue.installPlugin(createjs.Sound);
        @queue.loadManifest(@assets.sounds)
      @queue.load()

    onLoadComplete: (e)=>
      @setup()

    setup: ->
      stage = @getStage()
      Utils.centerOnStage(stage, @, @width)
      Utils.centerRegistration(@, @width, @height)

    createBitmapFromResult: (q, id)->
      result = q.getResult(id)
      bitmap = new createjs.Bitmap(result)
      bitmap.id = id
      return bitmap