define ['easel',
        'preload',
        'UILayout',
        'Utils',
        'JsonExport'], (createjs, Preload, UILayout, Utils, JsonExport)->

  class MusicalZoo
    constructor: ->
      @stage       = new createjs.Stage('musicalzoo-stage');
      @stageWidth  = @stage.canvas.width
      @stageHeight = @stage.canvas.height
      @queue       = new createjs.LoadQueue(true)

      @manifest    = null
      @uiLayout    = null

      @stage.enableMouseOver(55)
      createjs.Touch.enable(@stage)
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

  window.MZ = new MusicalZoo();
  createjs.Ticker.addEventListener('tick', MZ.stage)

  # console.log JsonExport.makePianoKeyJson().imageJson



