define ['Instrument',
        'Drum'], (Instrument, Drum)->

  class DrumKit extends Instrument
    constructor: ()->
      super
      @id = 'drums'
      @componentClass = Drum
      @width = 570
      @height = 430

    addComponent: (data)->
      image = @getImage(data.id)
      data.image = image

      drum = new Drum(data)
      @container.addChild(drum.getDisplayObj())
      return drum

    # Parses the raw drums manifest and returns an object
    # containing two manifest objects, one for images and one for sounds.
    parseManifest: (manifest)->
      imagePath  = manifest.imagePath
      soundPath  = manifest.soundPath
      imageExt   = manifest.imageExt
      soundExt   = manifest.soundExt
      components = manifest.components

      components.forEach (element, array, index)=>
        id = element.id
        imageId = element.id + '_img'
        fullImagePath = imagePath + element.imgSrc + imageExt
        #
        soundId = element.id + '_snd'
        fullSoundPath = soundPath + element.soundSrc + soundExt
        # Add the parsed data to the new image manifest
        @assetManifest.push {id:imageId, src:fullImagePath}, {id:soundId, src:fullSoundPath}
        @componentData.push {id:id, coords: element.coords, keyInput:element.keyInput}

    setup: ->
      @componentData.forEach (element, array, index)=>
        # Will need to add a special case for the kick drum
        if element.id == "bassDrum"
          @addComponent(element).register()
        else
          @addComponent(element).register()
      @show()


