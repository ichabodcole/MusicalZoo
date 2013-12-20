define ['Instrument',
        'PianoKeyFactory'], (Instrument, PianoKeyFactory)->

  class Piano extends Instrument
    constructor: ()->
      @bgImage    = null
      @bgBitmap   = null
      @keyboard   = new createjs.Container()
      @topKeys    = new createjs.Container()
      @bottomKeys = new createjs.Container()
      @keyboard.mouseDown = false
      @width = 539
      @height = 533
      super
      @id = 'piano'

      @getDisplayObj().addChild(@keyboard)
      @keyboard.addChild(@bottomKeys)
      @keyboard.addChild(@topKeys)
      @setKeyBoardPosition()

    setup: ->
      super
      @keyboard.on 'mousedown', @handleMouse
      @keyboard.on 'pressup', @handleMouse

    handleMouse: (e)=>
      if e.type == 'mousedown'
        @keyboard.mouseDown = true
      else if e.type == 'pressup'
        @keyboard.mouseDown = false

    setKeyBoardPosition: ->
      @keyboard.x = 37
      @keyboard.y = 418

    addBgImage: ->
      obj = @getDisplayObj()
      @bgBitmap = new createjs.Bitmap(@bgImage)
      obj.addChildAt(@bgBitmap, @getDisplayObj().getChildIndex(@keyboard))

    addComponent: (data)->
        keyType = data.type
        image = @getImage(data.id)
        data.image = image

        component = PianoKeyFactory.create(keyType, data, @keyboard)

        if keyType == 'top'
          @topKeys.addChild(component.getDisplayObj())
        else
          @bottomKeys.addChild(component.getDisplayObj())
        return component

    parseManifest: (manifest)->
      imagePath  = manifest.imagePath
      soundPath  = manifest.soundPath
      imageExt   = manifest.imageExt
      soundExt   = manifest.soundExt
      components = manifest.components
      @bgImage   = imagePath + manifest.bgImage

      components.forEach (element, array, index)=>
        id = element.id
        imageId = element.id + '_img'
        fullImagePath = imagePath + element.imgSrc + imageExt
        #
        soundId = element.id + '_snd'
        fullSoundPath = soundPath + element.soundSrc + soundExt
        # Add the parsed data to the new image manifest
        @assetManifest.push {id:imageId, src:fullImagePath}, {id:soundId, src:fullSoundPath}
        @componentData.push {id:id, type: element.type, coords: element.coords, keyInput:element.keyInput}

      @parseManifestComplete()

    parseManifestComplete: ->
      @addBgImage()