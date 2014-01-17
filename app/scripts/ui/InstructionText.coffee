define ['easel'], (createjs)->

  class InstructionText extends createjs.Text
    constructor: (text, x, y, lineWidth)->
      @initialize(text, "30px " + window.MZ.mainFont, "#ffffff")
      @x = x ? 0
      @y = y ? 0
      @lineWidth = lineWidth ? null
      @lineHeight = 40
