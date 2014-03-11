{$, View} = require 'atom'
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
    @highlightHexRGBorRGBa()
    @highlightHSLorHSLa()

  highlightHexRGBorRGBa: ->
    elements = CssColorHighlight.findHexRGBorRGBColors(@editorView)
    for i, element of elements
      if element != undefined and element.style != undefined
        hexColor = @extractHexColor(element)
        lightness = @getLightnessFromHexColor(hexColor)
        @updateElement(element, hexColor, lightness)

  highlightHSLorHSLa: ->
    elements = CssColorHighlight.findHSLorHSLaColors(@editorView)
    for i, element of elements
      $element = $(element)
      hsl = @extractHSLColor($element)
      hexColor = ColorUtil.HSLtoHex(hsl)
      lightness = hsl[2] / 100

      for i, item of CssColorHighlight.getHSLColorElements($element)
        @updateElement(item, hexColor, lightness)

  updateElement: (element, hexColor, lightness) ->
    if lightness < parseFloat(atom.config.get('css-color-highlight.lightnessFactor'))
      color = atom.config.get('css-color-highlight.lightColor')
    else
      color = atom.config.get('css-color-highlight.darkColor')

    element.style.backgroundColor = hexColor;
    element.style.color = color

  extractHSLColor: ($element) ->
    hsl = []
    for i, item of $element.parent().find(".constant.numeric").toArray()
      hsl.push parseInt(item.textContent, 10)

    hsl

  extractHexColor: (element) ->
    strColor = element.textContent

    if (array = /(\d{1,3}),\s*(\d{1,3}),\s*(\d{1,3})/.exec(strColor)) != null
      r = parseInt(array[1], 10)
      g = parseInt(array[2], 10)
      b = parseInt(array[3], 10)
      return ColorUtil.RGBtoHex([r, g, b])

    if strColor.indexOf("#") == -1
      return ColorUtil.colorNameToHex(strColor)

    strColor

  getLightnessFromHexColor: (hexColor) ->
    ColorUtil.RGBtoHSL(ColorUtil.hexToRGB(hexColor))[2]

  @getHSLColorElements: ($element) ->
    items = $element.find("~ .punctuation, ~ .constant.numeric, ~ .keyword.other.unit").toArray()
    items.shift() # (
    items.pop();  # )

    if $element.text() == "hsla"
      items.pop() # alpha
      items.pop() # ,

    items

  @findHexRGBorRGBColors: (editorView) ->
    editorView[0].querySelectorAll(".lines .constant.color")

  @findHSLorHSLaColors: (editorView) ->
    editorView.find(".css .support.function.misc:contains('hsl'), .css .support.function.misc:contains('hsla')").toArray()
