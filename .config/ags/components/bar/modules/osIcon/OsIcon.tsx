import app from "ags/gtk4/app"
import { Gdk } from "ags/gtk4"
import { execAsync } from "ags/process";
import { createState } from "ags";

export default function OsIcon() {
  const [icon, _setIcon] = createState("linux");

  async function getOsIcon(): Promise<string> {
    const osName = await execAsync(['sh', '-c', 'grep ^NAME= /etc/os-release | cut -d= -f2- | tr -d \'"\'']).catch(() => "linux");
    switch (osName) {
      case "Arch Linux":
        return "arch";
      default:
        return "linux";
    }
  }

  getOsIcon().then((iconName) => {
    _setIcon(iconName);
  });

  return (
    <button
      class="OsIcon transparentThenHoverFg"
      cursor={Gdk.Cursor.new_from_name("pointer", null)}
    >
      <image
        file={icon(icon => `icons/os/${icon}.svg`)}
      />
    </button>
  );
}