define ['InstrumentComponent', 'CelloString'], (InstrumentComponent, CelloString)->

  class CelloStrings extends InstrumentComponent
    constructor: (name, manifest)->
      super(name, manifest)
      @mouseDown = false

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

    deregister: ->
      super()
      @off 'mousedown', @handleMouseDown
      @off 'pressup', @handlePressUp

    handleMouseDown: (e)=>
      @mouseDown = true

    handlePressUp: (e)=>
      @mouseDown = false