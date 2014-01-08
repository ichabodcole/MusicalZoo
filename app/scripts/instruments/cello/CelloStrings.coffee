define ['InstrumentComponent', 'CelloString'], (InstrumentComponent, CelloString)->

  class CelloStrings extends InstrumentComponent
    constructor: (name, manifest)->
      super(name, manifest)
      @keyCount  = 0
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
      @on 'mousedown', @onMouseDown
      @on 'pressup', @onPressUp
      @on 'mouseover', @onMouseOver
      @on 'mouseout', @onMouseOut

    deregister: ->
      super()
      @removeAllEventListeners('mousedown')
      @removeAllEventListeners('pressup')
      @removeAllEventListeners('mouseover')
      @removeAllEventListeners('mouseout')

    onMouseDown: (e)=>
      @mouseDown = true
      @dispatchEvent(@stringsPlayingEvent)

    onPressUp: (e)=>
      @mouseDown = false
      console.log @mouseOver , @mouseOverCello
      if @mouseOver == true && @mouseOverCello == true
        @dispatchEvent(@stringsReadyEvent)

    onMouseOver: (e)=>
      @mouseOver = true
      if @mouseDown == true
        @dispatchEvent(@stringsPlayingEvent)
      @clearTimer()

    onMouseOut: (e)=>
      @mouseOver = false
      if @to then window.clearTimeout(@to)
      @to = setTimeout =>
        @dispatchEvent(@stringsReadyEvent)
      , 700

    clearTimer: ->
      if @to? then window.clearTimeout(@to)