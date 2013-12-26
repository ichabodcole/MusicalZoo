define ['Instrument', 'tween'], (Instrument, Tween)->

  class Cello extends Instrument
    constructor: (name, manifest)->
      super name, manifest
      @bow = @getChildByName('bow')
      @strings = @getChildByName('strings')
      @swapChildren(@bow, @strings)
      @bowStartY = @bow.y
      @bowStartX = @bow.x
      @bowState  = 0

    setup: =>
      super()
      @backgroundImage.on 'rollover', @handleMouseOver
      @backgroundImage.on 'rollout', @handleMouseOut

    handleMouseOver: (e)=>
      if @bowState == 0
        endX = @bowStartX - 30
        endY = @bowStartY - 90
        easePos = createjs.Ease.cubicInOut
        transitionTime = 500

        createjs.Tween.get(@bow)
          .to({x:endX, y:endY}, transitionTime, easePos)

        endRot = -80
        transitionTime = 1000
        easeRot = createjs.Ease.elasticOut
        createjs.Tween.get(@bow)
        .to({rotation: endRot}, transitionTime, easeRot)

        @bowState = 1

    handleMouseOut: (e)=>
      if @bowState == 1
        endX = @bowStartX
        endY = @bowStartY
        endRot = 0
        ease = createjs.Ease.cubicInOut
        transitionTime = 500
        createjs.Tween.get(@bow)
          .to({x:endX, y:endY}, transitionTime, ease)

        endRot = 0
        transitionTime = 1000
        easeRot = createjs.Ease.elasticOut
        createjs.Tween.get(@bow)
        .to({rotation: endRot}, transitionTime, easeRot)

        @bowState = 0