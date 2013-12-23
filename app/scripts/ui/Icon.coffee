define ['easel',
        'sound',
        'tween',
        'Springy',
        'Utils'], (createjs, Sound, Tween, Springy, Utils)->

  class Icon extends createjs.Container
    constructor: (id, image, data)->
      @initialize()
      @id = id
      @soundClickId = @id + "Click_snd"
      @soundOverId  = @id + "Over_snd"

      @width    = data.width
      @height   = data.height
      @coords   = data.coords
      @link     = data.link

      @bgBitmap = new createjs.Bitmap(image)

      @addChild(@bgBitmap)
      @setup()

    setup: ->
      createjs.EventDispatcher.initialize(@)
      @x = @coords.x
      Utils.centerRegistration(@, @width, @height)
      @on "mouseover", @onMouseOver
      @on "click", @onClick

    tearDown: ->
      @off "mouseover", @onMouseOver
      @off "click", @onClick

    onClick: (e)=>
      ease = createjs.Ease.linear
      createjs.Tween.removeTweens(@)
      createjs.Tween.get(@)
      .to({
        scaleX: .70,
        scaleY: .70
      }, 80, ease)
      .call(@descale)
      # play the click sound
      createjs.Sound.play(@soundClickId)
      #
      iconEvent = new createjs.Event("iconClick", true)
      @dispatchEvent(iconEvent)

    descale: =>
      ease = createjs.Ease.elasticOut
      createjs.Tween.get(@).to({
        scaleX: 1,
        scaleY: 1
      }, 1500, ease)


    onMouseOver: =>
      ease = createjs.Ease.elasticOut
      @scaleX = .95
      @scaleY = .95
      createjs.Tween.get(@).to({
        scaleX: 1,
        scaleY: 1
      }, 1000, ease)
      # play the over sound
      createjs.Sound.play(@soundOverId)
