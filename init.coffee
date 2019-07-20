# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to log to the console when each text editor is saved.
#
# atom.workspace.observeTextEditors (editor) ->
#   editor.onDidSave ->
#     console.log "Saved! #{editor.getPath()}"

atom.workspace.getPanes().forEach (pane)->
  pane.currentActiveItem = pane.getActiveItem()
  pane.onDidChangeActiveItem (item)->
    pane.lastActiveItem = pane.currentActiveItem
    pane.currentActiveItem = item

atom.commands.add 'atom-workspace', 'vim:previous-file', ->
  pane = atom.workspace.getActivePane()
  if pane.lastActiveItem
    pane.setActiveItem pane.lastActiveItem
    if pane.getActiveItem().focusActivePanel
      pane.getActiveItem().focusActivePanel()
