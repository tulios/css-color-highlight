DefaultBrowserColors = require './default-browser-colors'

module.exports =
class ColorUtil

  @RGBtoHex: (rgb) ->
    colr = '#'
    colr += Math.floor(rgb[0]).toString(16)
    colr += Math.floor(rgb[1]).toString(16)
    colr += Math.floor(rgb[2]).toString(16)
    colr

  @RGBtoHSL: (rgb) ->
    r = rgb[0]
    g = rgb[1]
    b = rgb[2]

    r /= 255
    g /= 255
    b /= 255
    max = Math.max(r, g, b)
    min = Math.min(r, g, b)
    l = (max + min) / 2

    if max == min
      h = s = 0 # achromatic
    else
      d = max - min
      s = if l > 0.5 then d / (2 - max - min) else d / (max + min)

      switch max
        when r
          h = (g - b) / d + (if g < b then 6 else 0)
        when g
          h = (b - r) / d + 2
        when b
          h = (r - g) / d + 4

      h /= 6

    [h, s, l]

  @hexToRGB: (hex) ->
    r = hex.substr(hex.indexOf("#") + 1)
    threeDigits = r.length == 3;
    r = @parseHex(r);
    threeDigits and (r = (((r & 0xF00) * 0x1100) | ((r & 0xF0) * 0x110) | ((r & 0xF) * 0x11)));

    g = (r & 0xFF00) / 0x100;
    b =  r & 0xFF;
    r =  r >>> 0x10;

    [r, g, b]

  @colorNameToHex: (color) ->
    defaults = DefaultBrowserColors.colors()
    if (hexa = defaults[color.toLowerCase()]) != undefined
      return hexa;

    "#000000"

  @parseHex: (hex) ->
     parseInt(hex, 16)
