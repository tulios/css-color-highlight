{WorkspaceView} = require 'atom'
CssColorHighlight = require '../lib/css-color-highlight'

describe "CssColorHighlight", ->

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage('language-sass')

    atom.workspaceView = new WorkspaceView
    atom.workspaceView.openSync('sample.css.scss')
    atom.workspaceView.attachToDom()

    @editorView = atom.workspaceView.getActiveView()[0]

    waitsForPromise ->
      atom.packages.activatePackage('css-color-highlight')

  describe "with hex colors", ->
    describe "and dark color", ->
      it "should add the color value into its element background", ->
        line = @editorView.querySelectorAll(".lines .constant.color")[0]
        expect(line.textContent).toBe("#C7504E")
        expect(line.style.backgroundColor).toBe("rgb(199, 80, 78)")
        expect(line.style.color).toBe("rgb(255, 255, 255)")

    describe "and light color", ->
      it "should add the color value into its element background", ->
        line = @editorView.querySelectorAll(".lines .constant.color")[1]
        expect(line.textContent).toBe("#d59392")
        expect(line.style.backgroundColor).toBe("rgb(213, 147, 146)")
        expect(line.style.color).toBe("rgb(0, 0, 0)")

  describe "with literal colors", ->
    describe "and dark color", ->
      it "should add the color value into its element background", ->
        line = @editorView.querySelectorAll(".lines .constant.color")[2]
        expect(line.textContent).toBe("black")
        expect(line.style.backgroundColor).toBe("black")
        expect(line.style.color).toBe("rgb(255, 255, 255)")

    describe "and light color", ->
      it "should add the color value into its element background", ->
        line = @editorView.querySelectorAll(".lines .constant.color")[3]
        expect(line.textContent).toBe("white")
        expect(line.style.backgroundColor).toBe("white")
        expect(line.style.color).toBe("rgb(0, 0, 0)")

  describe "with rgb colors", ->
    describe "and dark color", ->
      it "should add the color value into its element background", ->
        line = @editorView.querySelectorAll(".lines .constant.color")[4]
        expect(line.textContent).toBe("199, 80, 78")
        expect(line.style.backgroundColor).toBe("rgb(199, 80, 78)")
        expect(line.style.color).toBe("rgb(255, 255, 255)")

    describe "and light color", ->
      it "should add the color value into its element background", ->
        line = @editorView.querySelectorAll(".lines .constant.color")[5]
        expect(line.textContent).toBe("213, 147, 146")
        expect(line.style.backgroundColor).toBe("rgb(213, 147, 146)")
        expect(line.style.color).toBe("rgb(0, 0, 0)")

  describe "with rgba colors", ->
    describe "and dark color", ->
      it "should add the color value into its element background", ->
        line = @editorView.querySelectorAll(".lines .constant.color")[6]
        expect(line.textContent).toBe("199, 80, 78")
        expect(line.style.backgroundColor).toBe("rgb(199, 80, 78)")
        expect(line.style.color).toBe("rgb(255, 255, 255)")

    describe "and light color", ->
      it "should add the color value into its element background", ->
        line = @editorView.querySelectorAll(".lines .constant.color")[7]
        expect(line.textContent).toBe("213, 147, 146")
        expect(line.style.backgroundColor).toBe("rgb(213, 147, 146)")
        expect(line.style.color).toBe("rgb(0, 0, 0)")
