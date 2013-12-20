define ['easel'], (createjs)->

  class Title extends createjs.Container
    constructor: (q)->
      @initialize()
      @setup(q)

    setup: (q)->
      @title = @createBitmapFromResult(q, 'musicalZooTitle')

    createBitmapFromResult: (q, id)->
      result = q.getResult(id)
      bitmap = new createjs.Bitmap(result)
      @addChild(bitmap)
      return bitmap

