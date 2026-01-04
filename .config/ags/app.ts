import app from "ags/gtk4/app"
import style from "./style.scss"
import Bar from "./components/bar/Bar"

app.start({
  css: style,
  main() {
    // Create a bar for each monitor
    app.get_monitors().map(Bar);
  },
})
