define ['easel'], (createjs)->
  class Instrument
    constructor: ->
      @container = new createjs.Container()
      @container.cursor = "pointer"
      # console.log('I\'m an Instrument')

    parseManifest: (manifest)->

    loadAssets: (imageManifest, soundManifest)->

    setCoords: (coordsManifest)->

    handleFileLoad: (e)=>

    loadComplete: (e)=>

    getDisplayObj: ->
      return @container
