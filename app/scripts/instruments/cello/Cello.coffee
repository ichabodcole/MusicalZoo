define ['Instrument'], (Instrument)->

  class Cello extends Instrument
    constructor: (id)->
      @bgImage    = null
      @bgBitmap   = null
      @strings  = new createjs.Container()
      @bow      = new createjs.Bitmap()
      @width = 539
      @height = 533
      super(id)

      @addChild(@strings)
      @setStringsPosition()

    setup: ->
      super
      @keyboard.on 'mousedown', @handleMouse
      @keyboard.on 'pressup', @handleMouse

    handleMouse: (e)=>
      if e.type == 'mousedown'
        @keyboard.mouseDown = true
      else if e.type == 'pressup'
        @keyboard.mouseDown = false

    setStringsPosition: ->
      @strings.x = 37
      @strings.y = 418

    addBgImage: ->
      @bgBitmap = new createjs.Bitmap(@bgImage)
      @addChildAt(@bgBitmap, @getChildIndex(@keyboard))

    addComponent: (data)->
        # keyType = data.type
        # image = @getImage(data.id)
        # data.image = image

        # component = PianoKeyFactory.create(keyType, data, @keyboard)

        # if keyType == 'top'
        #   @topKeys.addChild(component.getDisplayObj())
        # else
        #   @bottomKeys.addChild(component.getDisplayObj())
        # return component

    parseManifest: (manifest)->
      # imagePath  = manifest.imagePath
      # soundPath  = manifest.soundPath
      # imageExt   = manifest.imageExt
      # soundExt   = manifest.soundExt
      # components = manifest.components
      # @bgImage   = imagePath + manifest.bgImage

      # components.forEach (element, array, index)=>
      #   id = element.id
      #   imageId = element.id + '_img'
      #   fullImagePath = imagePath + element.imgSrc + imageExt
      #   #
      #   soundId = element.id + '_snd'
      #   fullSoundPath = soundPath + element.soundSrc + soundExt
      #   # Add the parsed data to the new image manifest
      #   @assetManifest.push {id:imageId, src:fullImagePath}, {id:soundId, src:fullSoundPath}
      #   @componentData.push {id:id, type: element.type, coords: element.coords, keyInput:element.keyInput}

      # @parseManifestComplete()

    parseManifestComplete: ->
      @addBgImage()