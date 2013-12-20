define ['easel'], (createjs)->

  class IconLayout extends createjs.Container
    constructor: (q, @app)->
      @initialize()
      @setup(q)
      @icons
      @width  = 603
      @height = 212

    setup: (q)->
      @icons     = []
      @drumsIcon = @createBitmapFromResult(q, 'drumsIcon')
      @pianoIcon = @createBitmapFromResult(q, 'pianoIcon')
      @celloIcon = @createBitmapFromResult(q, 'celloIcon')

      @pianoIcon.x = 250
      @celloIcon.x = 450

      for icon in @icons
        icon.on 'click', @handleClick

    go: (e)->
      console.log e

    handleClick: (e)=>
      e.target.scaleX = .95
      e.target.scaleY = .95
      setTimeout ->
        e.target.scaleX = 1
        e.target.scaleY = 1
      , 50
      @app.dispatchEvent(new createjs.Event(e.target.id + "Click"))

    createBitmapFromResult: (q, iconId)->
      result = q.getResult(iconId)
      bitmap = new createjs.Bitmap(result)
      bitmap.id = iconId
      @icons.push(bitmap)
      @addChild(bitmap)
      return bitmap


