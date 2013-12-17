define ['easel'], (createjs)->
  class Instrument
    constructor: ->
      @container = new createjs.Container()
      @container.cursor = "pointer"
      # console.log('I\'m an Instrument')


    getDisplayObj: ->
      return @container
