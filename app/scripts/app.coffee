define ['easel', 'preload', 'DrumKit'], (createjs, Preload, DrumKit)->

  class App
    constructor: ->
      @stage = new createjs.Stage('musicalzoo-stage');
      @stage.enableMouseOver(55)

      @queue = new createjs.LoadQueue(true)

      # @drumKit = new DrumKit()
      # @stage.addChild(@drumKit.getDisplayObj());
      @loadManifest()

    loadManifest: ->
      @queue.addEventListener('fileload', @onManifestLoad)
      @queue.loadFile({src:'../musicalzoo_manifest.json', id:'manifest'})

    # Fat arrow for maintaining correct scope
    onManifestLoad: (e)=>
      @manifest = @queue.getResult('manifest')

      drumManifest = @parseDrumManifest(@manifest.drums)
      console.log(drumManifest)
      @loadDrums(drumManifest.imageManifest, drumManifest.soundManifest)
      # Remove the initial event listener
      @queue.removeEventListener('fileload', @onManifestLoad)

    # Parses the raw drums manifest and returns an object
    # containing two manifest objects, one for images and one for sounds.
    parseDrumManifest: (manifest)->
      imagePath = manifest.imagePath
      soundPath = manifest.soundPath
      imageExt = manifest.imageExt
      soundExt = manifest.soundExt
      drumList  = manifest.drumList

      imageManifest = []
      soundManifest = []
      drumList.forEach (element, array, index)->
        imageId = element.id + '_img'
        fullImagePath = imagePath + element.imgSrc + imageExt
        #
        soundId = element.id + '_snd'
        fullSoundPath = soundPath + element.soundSrc + soundExt
        # Add the parsed data to the new image manifest
        imageManifest.push {id:imageId, src:fullImagePath}
        soundManifest.push {id:soundId, src:fullSoundPath}

      return {imageManifest: imageManifest, soundManifest: soundManifest}

    loadDrums: (drumImageManifest, drumSoundManifest)->
      @queue.addEventListener('fileload', @handleFileLoad)
      @queue.addEventListener('complete', @loadComplete)
      @queue.loadManifest(drumImageManifest)

    handleFileLoad: (e)=>

    loadComplete: (e)=>


  app = new App();
  createjs.Ticker.addEventListener('tick', app.stage)


