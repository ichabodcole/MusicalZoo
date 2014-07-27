define ->
  class Springy

    @PLAYING:'playing'
    @PAUSED:'paused'

    constructor: (amplitude, frequency, decay, targets)->
      @amplitude = 0.05 ? amplitude
      @frequency = 2.5  ? frequency
      @decay     = 2    ? decay
      @targets   = []   ? targets
      @time      = 0
      @state     = @PLAYING

    addTarget: (id, target, attribute, endValue)->
      value = target[attribute]
      unless @idExists(id)
        @targets.push({ id:id, target:target, attribute:attribute, endValue:endValue, value:value })
      else
        # console.log("Springy target with id: #{id} already exists")

    idExists: (id)->
      filtered = @targets.filter (element, index, array)->
        return element.id == id

      if filtered.length > 0
        return true
      return false

    setValue: (id, endValue)->
      filtered = @targets.filter (element, index, array)->
        return element.id = id
      # Filter returns an array even if only one elment is returned
      filtered[0].endValue = endValue

    removeTarget: (id)->
      @targets = @targets.filter (element, index, array)->
        return !element.id == id

    reset: ->
      @targets = []
      time    = 0

    updateTargets: ->
      targets.forEach (element, index, array)=>
        target    = element.target
        attribute = element.attribute
        endValue  = element.endValue
        value     = element.value

        newValue = @spring(endValue, value)
        target[attribute] = newValue
        element.value = newValue

    spring: (endValue, value)->
      velocity = endValue - value
      if velocity > .01
        value += velocity * @amplitude *
                 Math.sin(@frequency * @time * 2 *
                 Math.PI) / Math.exp(@decay * @time)

    update: ->
      if @state != @PAUSED
        @time++
        @updateTargets()

    pause: ->
      @state = @PAUSED

    play: ->
      @state = @PLAYING

    # Setters
    setAmplitude:(@amplitude)->
    setFrequency: (@frequency)->
    setDecay: (@decay)->
    setTargets: (@targets)->
