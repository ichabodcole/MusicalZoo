define ['easel', 'preload', 'DrumKit'], (createjs, Preload, DrumKit)->

  class App
    constructor: ->
      @stage = new createjs.Stage('musicalzoo-stage');
      @stage.enableMouseOver(55)
      @stageWidth = @stage.canvas.width
      @stageHeight = @stage.canvas.height

      @queue = new createjs.LoadQueue(true)

      @drumKit = new DrumKit()
      @drumKit.getDisplayObj().x = @stageWidth / 2 - 580 / 2
      @stage.addChild(@drumKit.getDisplayObj());
      @loadManifest()

    loadManifest: ->
      @queue.addEventListener('fileload', @onManifestLoad)
      @queue.loadFile({src:'../musicalzoo_manifest.json', id:'manifest'})

    # Fat arrow for maintaining correct scope
    onManifestLoad: (e)=>
      @manifest = @queue.getResult('manifest')

      @drumKit.loadManifestAssets(@manifest.drums)
      # Remove the initial event listener
      @queue.removeEventListener('fileload', @onManifestLoad)


  app = new App();
  createjs.Ticker.addEventListener('tick', app.stage)


