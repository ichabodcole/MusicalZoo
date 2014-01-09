define ->

  class KeyLogger
    constructor: ->
      @keys = []
      @register()

    register: ->
      document.addEventListener 'keydown', @onKeyDown
      document.addEventListener 'keyup', @onKeyUp

    deregister: ->
      document.removeEventListener 'keydown', @onKeyDown
      document.removeEventListener 'keyup', @onKeyUp

    onKeyDown: (e)=>
      key = e.which
      keys[key] = true

    onKeyUp: (e)=>
      key = e.which
      keys[key] = false

    keyIsDown: (key)->
      if keys[key] == true
        return true
      else
        return false

  unless window.keyLogger instanceof KeyLogger
    window.keyLogger = new KeyLogger()
