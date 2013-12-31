define ['InstrumentComponent', 'CelloString'], (InstrumentComponent, CelloString)->

  class CelloStrings extends InstrumentComponent
    constructor: (name, manifest)->
      super(name, manifest)
      @mouseDown = false
      @mouseOver = false
      @mouseOverCello = false

      @setEvents()

    setEvents: ->
      @stringsPlayingEvent = new createjs.Event('stringsPlaying', true)
      @stringsDefaultEvent = new createjs.Event('stringsDefault', true)
      @stringsReadyEvent   = new createjs.Event('stringsReady', true)
      @stringsOverEvent    = new createjs.Event('stringsOver', true)

    parseManifest: (manifest)->
      super(manifest)
      if manifest.hitAreas?
        hitAreas = manifest.hitAreas
        hitAreas.forEach (hitArea, index)=>
          @addItem(hitArea.id, hitArea.data)

    addItem: (name, data)=>
      celloString = new CelloString(name, data)
      @addChild(celloString)
      @items.push(celloString)

    register:->
      super()
      @on 'mousedown', @handleMouseDown
      @on 'pressup', @handlePressUp
      @on 'mouseover', @handleMouseOver
      @on 'mouseout', @handleMouseOut

    deregister: ->
      super()
      @off 'mousedown', @handleMouseDown
      @off 'pressup', @handlePressUp
      @off 'mouseover', @handleMouseOver
      @off 'mouseout', @handleMouseOut

    handleMouseDown: (e)=>
      @mouseDown = true
      @dispatchEvent(@stringsPlayingEvent)

    handlePressUp: (e)=>
      @mouseDown = false
      if @mouseOver == true && @mouseOverCello == true
        @dispatchEvent(@stringsReadyEvent)

    handleMouseOver: (e)=>
      @mouseOver = true
      if @mouseDown == true
        @dispatchEvent(@stringsPlayingEvent)
      @clearTimer()

    handleMouseOut: (e)=>
      @mouseOver = false
      if @to then window.clearTimeout(@to)
      @to = setTimeout =>
        @dispatchEvent(@stringsReadyEvent)
      , 700

    clearTimer: ->
      if @to? then window.clearTimeout(@to)