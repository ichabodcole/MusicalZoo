define ['easel',
        'preload',
        'sound',
        'Instrument',
        'Drum'], (createjs, Preload, Sound, Instrument, Drum)->

  class DrumKit extends Instrument
    constructor: (options={})->
      super
      @queue = new createjs.LoadQueue(true)
      @queue.installPlugin(createjs.Sound)
      @assetManifest  = []
      @drumData       = []

    addDrum: (data)->
      image = @getDrumImage(data.id)
      data.image = image

      drum = new Drum(data)
      @container.addChild(drum.getDisplayObj())
      return drum

    # Parses the raw drums manifest and returns an object
    # containing two manifest objects, one for images and one for sounds.
    parseManifest: (manifest)->
      imagePath = manifest.imagePath
      soundPath = manifest.soundPath
      imageExt  = manifest.imageExt
      soundExt  = manifest.soundExt
      drumList  = manifest.drumList

      drumList.forEach (element, array, index)=>
        id = element.id
        imageId = element.id + '_img'
        fullImagePath = imagePath + element.imgSrc + imageExt
        #
        soundId = element.id + '_snd'
        fullSoundPath = soundPath + element.soundSrc + soundExt
        # Add the parsed data to the new image manifest
        @assetManifest.push {id:imageId, src:fullImagePath}, {id:soundId, src:fullSoundPath}
        @drumData.push {id:id, coords: element.coords}


    loadManifestAssets: (manifest)->
      @parseManifest(manifest)
      @queue.addEventListener('fileload', @handleFileLoad)
      @queue.addEventListener('complete', @loadComplete)
      @queue.loadManifest(@assetManifest)
      # @queue.loadManifest(soundAssetsManifest, false)

    handleFileLoad: (e)=>
      # console.log(e.result)

    loadComplete: (e)=>
      # console.log(@queue)
      @drumData.forEach (element, array, index)=>
        # Will need to add a special case for the kick drum
        if element.id == "bassDrum"
          @addDrum(element)
        else
          @addDrum(element)

    getDrumImage: (id)->
      image = @queue.getResult(id + '_img')


