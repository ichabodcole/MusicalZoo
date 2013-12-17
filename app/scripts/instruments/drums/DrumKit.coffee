define ['easel',
        'BassDrum',
        'RideCymbal'], (createjs, BassDrum, RideCymbal)->

  class DrumKit
    constructor: (options={})->

      @container = new createjs.Container()

      # Add Drums
      @bassDrum = new BassDrum()
      @rideCymbal = new RideCymbal()

      @addDrum(@bassDrum)
      @addDrum(@rideCymbal)

      @setDrumPositions()


    addDrum: (drumObj)->
      @container.addChild(drumObj.getDisplayObj())

    setDrumPositions: ->
      @bassDrum.setPosition(10, 100)
      @rideCymbal.setPosition(10, 0)

    getDisplayObj: ->
      return @container
