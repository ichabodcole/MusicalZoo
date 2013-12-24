define ['Key'], (Key)->

  class TopKey extends Key
    constructor: (name, data, image)->
      super(name, data, image)
      @startY = @y

    setup:(image, data)->
      @addImage(image)

    animate: ->
      @y += 2
      setTimeout ()=>
        @y = @startY
      , 150

    setData: (data)->
      for key, dataItem of data
        @[key] = dataItem