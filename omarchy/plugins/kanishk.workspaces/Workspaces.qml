import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import qs.Commons
import qs.Ui

BarWidget {
  id: root
  moduleName: "kanishk.workspaces"

  readonly property var allWorkspaceNames: ["1", "2", "B", "C", "M", "N", "P", "S", "T", "W"]
  readonly property var dellWorkspaceNames: ["1", "2", "B", "C", "N", "P", "S"]
  readonly property var lgWorkspaceNames: ["M", "T", "W"]
  readonly property var anchorWindow: root.QsWindow.window
  readonly property string screenName: anchorWindow && anchorWindow.screen
    ? String(anchorWindow.screen.name || "") : ""
  readonly property var visibleWorkspaceNames: workspaceNamesForScreen()

  function hasScreen(name) {
    var screens = Quickshell.screens || []

    for (var i = 0; i < screens.length; i++) {
      var screen = screens[i]
      if (screen && String(screen.name || "") === name && screen.width > 0 && screen.height > 0) return true
    }

    return false
  }

  function workspaceNamesForScreen() {
    var dellConnected = hasScreen("DP-1")
    var lgConnected = hasScreen("DP-2")

    if (!(dellConnected && lgConnected)) return allWorkspaceNames
    if (screenName === "DP-1") return dellWorkspaceNames
    if (screenName === "DP-2") return lgWorkspaceNames
    return allWorkspaceNames
  }

  function workspaceByName(name) {
    var values = Hyprland.workspaces.values

    for (var i = 0; i < values.length; i++) {
      if (String(values[i].name) === name) return values[i]
    }

    return null
  }

  function focusWorkspace(name) {
    if (!root.bar) return

    var target = /^\d+$/.test(name) ? name : "name:" + name
    root.bar.run("hyprctl dispatch " + Util.shellQuote("hl.dsp.focus({ workspace = \"" + target + "\" })"))
  }

  readonly property real trailingGap: root.vertical ? 0 : Style.spaceReal(1.5)

  implicitWidth: grid.implicitWidth + trailingGap
  implicitHeight: grid.implicitHeight

  GridLayout {
    id: grid
    anchors.fill: parent
    anchors.rightMargin: root.trailingGap
    columns: root.vertical ? 1 : root.visibleWorkspaceNames.length
    columnSpacing: root.vertical ? 0 : Style.space(1)
    rowSpacing: root.vertical ? Style.space(2) : 0

    Repeater {
      model: root.visibleWorkspaceNames

      WidgetButton {
        required property string modelData

        readonly property var workspace: root.workspaceByName(modelData)
        readonly property bool occupied: workspace !== null && workspace.toplevels.values.length > 0
        readonly property bool focused: Hyprland.focusedWorkspace !== null
          && String(Hyprland.focusedWorkspace.name) === modelData

        bar: root.bar
        text: modelData
        active: focused
        activeColor: Color.accent
        dimmed: !occupied && !focused
        tooltipText: "Workspace " + modelData
        horizontalMargin: 6
        verticalPadding: 6
        fixedWidth: root.vertical ? root.barSize : Style.space(20)
        fixedHeight: root.barSize
        onPressed: function() { root.focusWorkspace(modelData) }
      }
    }
  }
}
