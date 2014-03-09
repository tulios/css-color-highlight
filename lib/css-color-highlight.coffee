{View} = require 'atom'
ColorUtil = require './color-util'

module.exports =
class CssColorHighlight extends View

  constructor: (@editorView)->
    @subscribe @editorView, 'editor:display-updated', =>
      @render()

    @render()

  destroy: ->
    @unsubscribe()

  render: ->
    elements = @editorView[0].querySelectorAll(".lines .constant.color")
    for i, element of elements
      if element != undefined and element.style != undefined
        hexColor = @getHexColor(element)
        lightness = @getLightness(hexColor)
        @updateElement(element, hexColor, lightness)

  updateElement: (element, hexColor, lightness) ->
    if lightness < parseFloat(atom.config.get('css-color-highlight.lightnessFactor'))
      color = atom.config.get('css-color-highlight.lightColor')
    else
      color = atom.config.get('css-color-highlight.darkColor')

    element.style.backgroundColor = hexColor;
    element.style.color = color

  getHexColor: (element) ->
    strColor = element.textContent

    if (array = /(\d{1,3}),\s*(\d{1,3}),\s*(\d{1,3})/.exec(strColor)) != null
      r = parseInt(array[1], 10)
      g = parseInt(array[2], 10)
      b = parseInt(array[3], 10)
      return ColorUtil.RGBtoHex([r, g, b])

    if strColor.indexOf("#") == -1
      return ColorUtil.colorNameToHex(strColor)

    strColor

  getLightness: (hexColor) ->
    ColorUtil.RGBtoHSL(ColorUtil.hexToRGB(hexColor))[2]
