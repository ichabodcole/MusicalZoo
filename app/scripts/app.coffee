define ['easel',
        'preload',
        'UILayout',
        'Utils'], (createjs, Preload, UILayout, Utils)->

  class App
    constructor: ->
      @stage            = new createjs.Stage('musicalzoo-stage');
      @queue            = new createjs.LoadQueue(true)

      @manifest         = null
      @uiLayout         = null

      @stage.enableMouseOver(55)
      @loadManifest()

    loadManifest: ->
      @queue.addEventListener('fileload', @onManifestLoad)
      @queue.loadFile({src:'./musicalzoo_manifest.json', id:'manifest'})

    # Fat arrow for maintaining correct scope
    onManifestLoad: (e)=>
      @manifest = @queue.getResult('manifest')
      @addUILayout(@manifest)

      # Remove the initial event listener
      @queue.removeEventListener('fileload', @onManifestLoad)
      @queue.close()

    addUILayout: (manifest)->
      @uiLayout = new UILayout(manifest);
      @stage.addChild(@uiLayout)

  app = new App();
  createjs.Ticker.addEventListener('tick', app.stage)

  # console.log Utils.makePianoKeyJson().imageJson



