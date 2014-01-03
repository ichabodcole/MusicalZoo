define ['easel', 'tween', 'UIItem'], (createjs, Tween, UIItem)->

  class Preloader extends UIItem
    constructor: (manifest)->
      @bgImage = null
      super(manifest)
      @visible = false
      @scaleX = 0
      @scaleY = 0
      @queueList   = []
      @percentText = new createjs.Text('...', '40px Patrick Hand', '#ffffff')

    setup: ->
      super()
      @bgImage = @createBitmapFromResult(@queue, 'bgImage')
      @addChild(@bgImage)
      @addChild(@percentText)
      @percentText.x = @width/2 - 35
      @percentText.y = 80

    addQueueList: (@queueList)->
      for q in @queueList
        q.on 'progress', @onProgress

    onProgress: (e)=>
      queueNum = @queueList.length
      percent = Math.round(e.progress * 100)
      @percentText.text = percent + "%"

    reset: ->
      for q in @queueList
        q.off 'progress', @onProgress
      @queueList   = []
      @percentText.text = "..."

    show: =>
      @visible = true
      # tween vars
      ease = createjs.Ease.cubicOut
      endScaleX = 1
      endScaleY = 1
      transitionTime = 500
      createjs.Tween.get(@, {override: true})
        .to({scaleX:endScaleX , scaleY:endScaleY}, transitionTime, ease)

    hide: =>
      # tween vars
      ease = createjs.Ease.cubicIn
      endScaleX = 0
      endScaleY = 0
      transitionTime = 500
      createjs.Tween.get(@, {override: true})
        .to({scaleX:endScaleX , scaleY:endScaleY}, transitionTime, ease).call(@onHideComplete)

    onHideComplete: =>
      @visible = false

    onShowComplete: =>
