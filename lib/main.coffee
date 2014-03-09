CssColorHighlight = require './css-color-highlight'

module.exports =
  configDefaults:
    darkColor: "#000"
    lightColor: "#FFF"
    lightnessFactor: 0.55

  activate: ->
    @highlighters = []
    
    atom.workspaceView.eachEditorView (editorView) =>
      cssColorHighlight = new CssColorHighlight(editorView)
      @highlighters.push(cssColorHighlight);

  deactivate: ->
    for i, highlighter of @highlighters
      highlighter.destroy()
