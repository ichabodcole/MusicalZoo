define ['InstrumentComponent',
        'Valve'], (InstrumentComponent, Valve)->

  class Valves extends InstrumentComponent
    constructor: (name, manifest)->
      super(name, manifest)
      @keySet = 0
      @spaceKey = 32
      @spaceKeyDown = false
      @valveTimeout # set in onValueDown
      @valvePositionFactory = {
        valve_01: 0,
        valve_02: 1,
        valve_03: 2
      }

      @valveState = [0, 0, 0]
      @valveOpenState = [0, 0, 0].join()

    register: ->
      super()
      @on 'valveDown', @onValveDown
      @on 'valveUp', @onValveUp
      document.addEventListener 'keydown', @onKeyDown
      document.addEventListener 'keyup', @onKeyUp

    deregister: ->
      super()
      @removeAllEventListeners('valveDown')
      @removeAllEventListeners('valveUp')
      document.removeEventListener 'keydown', @onKeyDown
      document.removeEventListener 'keyup', @onKeyUp

    onKeyDown: (e)=>
      #TODO: Refactor - hard coded key string.
      e.preventDefault()
      if @spaceKeyDown == false
        if e.which == @spaceKey
          @spaceKeyDown = true
          @fadeOutSound() # fade out any already playing sounds
          @playSound('c_snd')

    onKeyUp: (e)=>
      #TODO: Refactor - hard coded key string, etc.
      e.preventDefault()
      if @spaceKeyDown == true
        if e.which == @spaceKey
          @spaceKeyDown = false
          @fadeOutSound()
        else if @valveState.join() == @valveOpenState
          @fadeOutSound() # fade out any already playing sounds
          @playSound('c_snd')

    onValveDown: (e)=>
      @setValveState(e.valve, 1)
      soundId = @getSoundIdByValveSetMatch()
      if soundId
        @createValveTimeout(soundId)

    onValveUp: (e)=>
      @setValveState(e.valve, 0)
      @fadeOutSound()
      soundId = @getSoundIdByValveSetMatch()
      if soundId
        @createValveTimeout(soundId)

    setValveState: (valveId, state)->
      valve = @valvePositionFactory[valveId]
      @valveState[valve] = state

    getSoundIdByValveSetMatch: ()->
      # keys are pulled from the manifest file and setup in setData method
      for key in @keys
        id       = key.id
        keySet   = key.keySet
        valveSet = key.valveSet
        if keySet == @keySet
          if @valvesMatch(@valveState, valveSet) && !@valveSetOpen(valveSet)
            return id + "_snd"
      # if no match return false
      return false

    # Creates a small timeout before playing a sound to account for
    # combo valve presses in keyboard input, where one key will always
    # hit slightly before the other.
    createValveTimeout: (soundId)->
      # the timeout gets reset when another key input event is recieved
      if @valveTimeout? then clearTimeout(@valveTimeout)
      @valveTimeout = setTimeout =>
        @fadeOutSound() # fade out any already playing sounds
        @playSound(soundId)
        @valveTimeout = null
        if @valveStateOpen() && !@spaceKeyDown
          @fadeOutSound()
      , 40

    valvesMatch: (valveSet1, valveSet2)->
      valveSet1.join() == valveSet2.join()

    valveSetOpen: (valveSet)->
      valveSet.join() == @valveOpenState

    valveStateOpen: (valveState)->
      @valveState.join() == @valveOpenState

    playSound: (soundId)->
      @sound = createjs.Sound.play(soundId, {loop: -1, volume: 0})
      transitionTime = 100
      endVolume = 1
      createjs.Tween.get(@sound, {override: true})
        .to({volume: endVolume}, transitionTime)

    stopSound: ()->
      if @sound?
        @sound.stop()

    fadeOutSound: ()->
      if @sound?
        transitionTime = 300
        endVolume = 0
        createjs.Tween.get(@sound, {override: true})
          .to({volume: endVolume}, transitionTime).call(@stopSound)

    addItem: (name, data, image)=>
      valve = new Valve(name, data, image)
      @addChild(valve)
      @items.push(valve)
