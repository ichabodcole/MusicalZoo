define ['Key'], (Key)->

  class TopKey extends Key
    constructor: (name, data, image)->
      super(name, data)
      @startY = @y
      @setup(data, image)

    setup:(data, image)->
      super(data)
      @addImage(image)

    addImage: (image)->
      bitmap = new createjs.Bitmap(image)
      @addChild(bitmap)

    animate: ->
      @y += 2
      setTimeout ()=>
        @y = @startY
      , 150

    setData: (data)->
      for key, dataItem of data
        @[key] = dataItem