import app from "ags/gtk4/app"
import style from "./style.scss"
import Bar from "./components/bar/Bar"

app.start({
  css: style,
  main() {
    // TODO Validate monitors

    app.get_monitors().map(Bar);

    // TODO Media player start/stop indicator
    // TODO Brightness change inidicator
    // TODO Volume change indicator
  },
})
