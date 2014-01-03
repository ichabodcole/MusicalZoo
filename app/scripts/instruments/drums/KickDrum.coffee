define ['Drum',
        'KickPedal'], (Drum, KickPedal)->

  class KickDrum extends Drum
    constructor: (name, data, image)->
      @kickPedal = null
      super(name, data, image)

    setup: (data, image)=>
      super(data, image)
      @kickPedal = new KickPedal(data.kickPedal)
      @addChildAt(@kickPedal, 0)

    animate: ->
      @kickPedal.animate()
      @bgImage.y -= 3
      setTimeout =>
        @bgImage.y += 3
      , 100





