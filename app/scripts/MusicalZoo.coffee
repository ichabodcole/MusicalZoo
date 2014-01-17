define ['easel',
        'preload',
        'Font',
        'UILayout',
        'Utils',
        'JsonExport'], (createjs, Preload, Font, UILayout, Utils, JsonExport)->

  class MusicalZoo
    constructor: ->
      @stage       = new createjs.Stage('musicalzoo-stage')
      @stageWidth  = @stage.canvas.width
      @stageHeight = @stage.canvas.height
      @queue       = new createjs.LoadQueue(true)
      @mainFont    = 'rich_handwritingregular'


      @manifest    = null
      @uiLayout    = null

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
      @uiLayout = new UILayout(manifest)
      @stage.addChild(@uiLayout)

  # Use the font library to make sure our custom font it loaded
  # before kicking off the MusicalZoo app
  font = new Font()
  font.fontFamily = "rich_handwritingregular"
  font.src = "rich_handwritingregular"
  font.onload = font.onerror = ->
    window.MZ = new MusicalZoo()
    createjs.Ticker.addEventListener('tick', MZ.stage)




