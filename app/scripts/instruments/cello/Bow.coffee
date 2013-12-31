define ['InstrumentComponent'], (InstrumentComponent)->

  class Bow extends InstrumentComponent
    DEFAULT: 'default'
    READY:   'ready'
    PLAYING: 'playing'

    constructor: (name, manifest)->
      super(name, manifest)
      @setup()
      @mouseEnabled = false
      @state        = @BOW_DEFAULT
      @startY       = @y
      @startX       = @x
      @timeline     = new createjs.Timeline()

      @readyStateData = {
        x: @startX
        y: @startY - 90
        rotation: -80
      }

      @playStateData = {
        x: @startX
        y: @startY - 90
        rotation: -80
      }

    setup: ->
      @regY = @height - 20
      @regX = @width / 2

    parseManifest: (manifest)->
      super(manifest)

    addItem: (name, data, image)=>
      bow = new createjs.Bitmap(image)
      bow.register = ->
      bow.deregister = ->
      @addChild(bow)
      @items.push(bow)

    stopTweens: ->

    gotoDefaultState: ->
      @state = @DEFAULT
      createjs.Tween.removeTweens(@)
      endX = @startX
      endY = @startY
      endRot = 0
      easePos = createjs.Ease.cubicInOut
      transitionTimePos = 500

      twn1 = createjs.Tween.get(@)
        .to({x:endX, y:endY}, transitionTimePos, easePos)

      transitionTimeRot = 1000
      endRot = 0
      easeRot = createjs.Ease.elasticOut

      twn2 = createjs.Tween.get(@)
        .to({rotation: endRot}, transitionTimeRot, easeRot)

    gotoReadyState: ->
      @state = @READY
      createjs.Tween.removeTweens(@)
      endX    = @startX
      endY    = @startY - 80
      easePos = createjs.Ease.cubicInOut
      transitionTimePos = 500

      twn1 = createjs.Tween.get(@)
        .to({x:endX, y:endY}, transitionTimePos, easePos)

      endRot  = -60
      easeRot = createjs.Ease.elasticOut
      transitionTimeRot = 1000

      twn2 = createjs.Tween.get(@)
        .to({rotation: endRot}, transitionTimeRot, easeRot)


    gotoPlayState: ->
      @state = @PLAYING
      createjs.Tween.removeTweens(@)
      curY    = @y
      curX    = @x
      curRot  = @rotation
      endX    = @startX - 50
      endY    = @startY - 105
      endX2   = @startX
      endY2   = @startY - 90
      endRot  = -80
      easePos = createjs.Ease.cubicInOut
      transitionTimePos = 800

      # @x = @startY - 95
      endRot = -80
      elasticEase = createjs.Ease.elasticOut

      @y = endY2
      @rotation = -80

      twnLoop = createjs.Tween.get(@, {loop: true, paused: true})
        .to({x:endX, y:endY, rotation: -85}, transitionTimePos, easePos)
        .to({x:endX2, y:endY2, rotation: -80}, transitionTimePos, easePos)

      @y = curY
      @x = curX
      @rotation = curRot

      twn = createjs.Tween.get(@, {override: true})
        .to({y: endY2, rotation: endRot}, 300, elasticEase).play(twnLoop)



