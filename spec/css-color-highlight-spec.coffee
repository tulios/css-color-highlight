{$, WorkspaceView} = require 'atom'
CssColorHighlight = require '../lib/css-color-highlight'

describe "CssColorHighlight", ->

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage('language-sass')

    atom.workspaceView = new WorkspaceView
    atom.workspaceView.openSync('sample.css.scss')
    atom.workspaceView.attachToDom()

    @editorView = atom.workspaceView.getActiveView()

    waitsForPromise ->
      atom.packages.activatePackage('css-color-highlight')

  describe "with HEX colors", ->
    describe "and dark color", ->
      it "should add the color value into its element background", ->
        line = CssColorHighlight.findHexRGBorRGBColors(@editorView)[0]
        expect(line.textContent).toBe("#C7504E")
        expect(line.style.backgroundColor).toBe("rgb(199, 80, 78)")
        expect(line.style.color).toBe("rgb(255, 255, 255)")

    describe "and light color", ->
      it "should add the color value into its element background", ->
        line = CssColorHighlight.findHexRGBorRGBColors(@editorView)[1]
        expect(line.textContent).toBe("#d59392")
        expect(line.style.backgroundColor).toBe("rgb(213, 147, 146)")
        expect(line.style.color).toBe("rgb(0, 0, 0)")

  describe "with LITERAL colors", ->
    describe "and dark color", ->
      it "should add the color value into its element background", ->
        line = CssColorHighlight.findHexRGBorRGBColors(@editorView)[2]
        expect(line.textContent).toBe("black")
        expect(line.style.backgroundColor).toBe("rgb(0, 0, 0)")
        expect(line.style.color).toBe("rgb(255, 255, 255)")

    describe "and light color", ->
      it "should add the color value into its element background", ->
        line = CssColorHighlight.findHexRGBorRGBColors(@editorView)[3]
        expect(line.textContent).toBe("white")
        expect(line.style.backgroundColor).toBe("rgb(255, 255, 255)")
        expect(line.style.color).toBe("rgb(0, 0, 0)")

  describe "with RGB colors", ->
    describe "and dark color", ->
      it "should add the color value into its element background", ->
        line = CssColorHighlight.findHexRGBorRGBColors(@editorView)[4]
        expect(line.textContent).toBe("199, 80, 78")
        expect(line.style.backgroundColor).toBe("rgb(199, 80, 78)")
        expect(line.style.color).toBe("rgb(255, 255, 255)")

      it "should correctly generate background colors for RGBs that result in less than 6 digits hexadecimals", ->
        line = CssColorHighlight.findHexRGBorRGBColors(@editorView)[6]
        expect(line.textContent).toBe("0, 206, 209")
        expect(line.style.backgroundColor).toBe("rgb(0, 206, 209)")
        expect(line.style.color).toBe("rgb(255, 255, 255)")

    describe "and light color", ->
      it "should add the color value into its element background", ->
        line = CssColorHighlight.findHexRGBorRGBColors(@editorView)[5]
        expect(line.textContent).toBe("213, 147, 146")
        expect(line.style.backgroundColor).toBe("rgb(213, 147, 146)")
        expect(line.style.color).toBe("rgb(0, 0, 0)")

  describe "with RGBA colors", ->
    describe "and dark color", ->
      it "should add the color value into its element background", ->
        line = CssColorHighlight.findHexRGBorRGBColors(@editorView)[7]
        expect(line.textContent).toBe("199, 80, 78")
        expect(line.style.backgroundColor).toBe("rgb(199, 80, 78)")
        expect(line.style.color).toBe("rgb(255, 255, 255)")

      it "should correctly generate background colors for RGBs that result in less than 6 digits hexadecimals", ->
        line = CssColorHighlight.findHexRGBorRGBColors(@editorView)[9]
        expect(line.textContent).toBe("0, 206, 209")
        expect(line.style.backgroundColor).toBe("rgb(0, 206, 209)")
        expect(line.style.color).toBe("rgb(255, 255, 255)")

    describe "and light color", ->
      it "should add the color value into its element background", ->
        line = CssColorHighlight.findHexRGBorRGBColors(@editorView)[8]
        expect(line.textContent).toBe("213, 147, 146")
        expect(line.style.backgroundColor).toBe("rgb(213, 147, 146)")
        expect(line.style.color).toBe("rgb(0, 0, 0)")

  describe "with HSL colors", ->
    describe "and dark color", ->
      it "should add the color value into its element background", ->
        line = CssColorHighlight.findHSLorHSLaColors(@editorView)[0]
        $line = $(line)
        expect($line.text()).toBe("hsl")
        items = CssColorHighlight.getHSLColorElements($line)
        expect(items[0].textContent).toBe("0")
        expect(items[1].textContent).toBe(",")
        expect(items[2].textContent).toBe("100")
        expect(items[3].textContent).toBe("%")
        expect(items[4].textContent).toBe(",")
        expect(items[5].textContent).toBe("25")
        expect(items[6].textContent).toBe("%")

        for i, item of items
          expect(item.style.backgroundColor).toBe("rgb(128, 0, 0)")
          expect(item.style.color).toBe("rgb(255, 255, 255)")

  describe "and light color", ->
    it "should add the color value into its element background", ->
      line = CssColorHighlight.findHSLorHSLaColors(@editorView)[1]
      $line = $(line)
      expect($line.text()).toBe("hsl")
      items = CssColorHighlight.getHSLColorElements($line)
      expect(items[0].textContent).toBe("0")
      expect(items[1].textContent).toBe(",")
      expect(items[2].textContent).toBe("100")
      expect(items[3].textContent).toBe("%")
      expect(items[4].textContent).toBe(",")
      expect(items[5].textContent).toBe("75")
      expect(items[6].textContent).toBe("%")

      for i, item of items
        expect(item.style.backgroundColor).toBe("rgb(255, 128, 128)")
        expect(item.style.color).toBe("rgb(0, 0, 0)")

  describe "with HSLA colors", ->
    describe "and dark color", ->
      it "should add the color value into its element background", ->
        line = CssColorHighlight.findHSLorHSLaColors(@editorView)[2]
        $line = $(line)
        expect($line.text()).toBe("hsla")
        items = CssColorHighlight.getHSLColorElements($line)
        expect(items[0].textContent).toBe("0")
        expect(items[1].textContent).toBe(",")
        expect(items[2].textContent).toBe("100")
        expect(items[3].textContent).toBe("%")
        expect(items[4].textContent).toBe(",")
        expect(items[5].textContent).toBe("25")
        expect(items[6].textContent).toBe("%")

        for i, item of items
          expect(item.style.backgroundColor).toBe("rgb(128, 0, 0)")
          expect(item.style.color).toBe("rgb(255, 255, 255)")

  describe "and light color", ->
    it "should add the color value into its element background", ->
      line = CssColorHighlight.findHSLorHSLaColors(@editorView)[3]
      $line = $(line)
      expect($line.text()).toBe("hsla")
      items = CssColorHighlight.getHSLColorElements($line)
      expect(items[0].textContent).toBe("0")
      expect(items[1].textContent).toBe(",")
      expect(items[2].textContent).toBe("100")
      expect(items[3].textContent).toBe("%")
      expect(items[4].textContent).toBe(",")
      expect(items[5].textContent).toBe("75")
      expect(items[6].textContent).toBe("%")

      for i, item of items
        expect(item.style.backgroundColor).toBe("rgb(255, 128, 128)")
        expect(item.style.color).toBe("rgb(0, 0, 0)")
