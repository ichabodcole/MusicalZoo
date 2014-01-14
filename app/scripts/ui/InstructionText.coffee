define ['easel'], (createjs)->

  class InstructionText extends createjs.Text
    constructor: (text, x, y, lineWidth)->
      @initialize(text, "25px Patrick Hand", "#ffffff")
      @x = x ? 0
      @y = y ? 0
      @lineWidth = lineWidth ? null
