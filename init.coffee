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

if !atom.workspace.getActivePaneItem()
  atom.workspace.open()

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

atom.commands.add 'atom-workspace', 'vim:w', ->
  atom.commands.dispatch(atom.views.getView(atom.workspace.getActivePaneItem()), 'core:save')

atom.commands.add 'atom-workspace', 'vim:wa', ->
  atom.commands.dispatch(atom.views.getView(atom.workspace.getActivePaneItem()), 'core:save-as')

atom.commands.add 'atom-workspace', 'vim:enew', ->
  atom.workspace.open()

atom.commands.add 'atom-workspace', 'vim:bd', ->
  atom.commands.dispatch(atom.views.getView(atom.workspace.getActivePaneItem()), 'tabs:close-tab')

atom.commands.add 'atom-workspace', 'vim:e', ->
  atom.commands.dispatch(atom.views.getView(atom.workspace.getActiveTextEditor()), 'advanced-open-file:toggle')
