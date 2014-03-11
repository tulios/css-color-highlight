DefaultBrowserColors = require './default-browser-colors'

module.exports =
class ColorUtil

  @RGBtoHex: (rgb) ->
    colr = '#'
    colr += ("0" + Math.floor(rgb[0]).toString(16)).slice(-2)
    colr += ("0" + Math.floor(rgb[1]).toString(16)).slice(-2)
    colr += ("0" + Math.floor(rgb[2]).toString(16)).slice(-2)
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

  @HSLtoHex: (hsl) ->
    @RGBtoHex(@HSLtoRGB(hsl))

  @HSLtoRGB: (hsl) ->
    h = hsl[0]
    s = hsl[1]/100
    l = hsl[2]/100

    h -= Math.floor(h / 360) * 360 if h >= 360
    h -= Math.ceil(h / 360) * 360  if h < 0
    h = h / 360

    if s == 0
      r = g = b = l # achromatic
    else
      if l < 0.5
        q = l * (1.0 + s)
      else
        q = l + s - (l * s)

      p = 2.0 * l - q

      r = @HUEtoRGB([p, q, h + 1/3])
      g = @HUEtoRGB([p, q, h])
      b = @HUEtoRGB([p, q, h - 1/3])

    [Math.round(r * 255), Math.round(g * 255), Math.round(b * 255)]

  @HUEtoRGB: (pqt) ->
    p = pqt[0]
    q = pqt[1]
    t = pqt[2]

    t += 1 if t < 0
    t -= 1 if t > 1
    return p + (q - p) * 6 * t if t * 6 < 1
    return q if t * 2 < 1
    return p + (q - p) * (2/3 - t) * 6 if t * 3 < 2
    return p

  @hexToRGB: (hex) ->
    r = hex.substr(hex.indexOf("#") + 1)
    threeDigits = r.length == 3;
    r = parseInt(r, 16)
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
