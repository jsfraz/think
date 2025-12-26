import app from "ags/gtk4/app"
import { Astal, Gtk, Gdk } from "ags/gtk4"
import OsIcon from "./modules/osIcon/OsIcon"
import Clock from "./modules/clock/Clock"
import BatteryIndicator from "./modules/batteryIndicator/BatteryIndicator"
import RunCat from "./modules/runCat/RunCat"
import TrayIcons from "./modules/trayIcons/TrayIcons"

/*
TODO Connected bluetooth devices indicator
TODO Connected network indicators (maybe network-manager-applet in tray)
TODO Current power profile indicator
TODO Volume indicator
TODO Notifications indicator
TODO Current workspace indicator
*/

export default function Bar(gdkmonitor: Gdk.Monitor) {
  const { TOP, LEFT, BOTTOM } = Astal.WindowAnchor

  return (
    <window
      name="bar"
      application={app}
      class="Bar"
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | BOTTOM}
      layer={Astal.Layer.TOP}
      visible
    >
      <centerbox
        cssName="centerbox"
        orientation={Gtk.Orientation.VERTICAL}
        class="glass-container"
      >
        <box
          $type="start"
          spacing={2}
          homogeneous={false}
          orientation={Gtk.Orientation.VERTICAL}
          class={"boxAnimation"}
        >
          <OsIcon />
        </box>
        <box
          $type="end"
          spacing={5}
          homogeneous={false}
          orientation={Gtk.Orientation.VERTICAL}
          class={"bottomPadding boxAnimation"}
        >
          <TrayIcons />
          <RunCat />
          <BatteryIndicator />
          <Clock />
        </box>
      </centerbox>
    </window>
  )
}

// <Gtk.Separator class="separator short-separator" />
