define ['easel'], (createjs)->
  class Instrument extends createjs.Container
    constructor: ->
      console.log('I\'m an Instrument')

  return Instrument
