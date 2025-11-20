import app from "ags/gtk4/app"
import style from "./style.scss"
import Bar from "./components/bar/Bar"
import PowerMenu from "./components/powerMenu/PowerMenu"
import Menu from "./components/menu/menu"
import { execAsync } from "ags/process"
import { Gdk } from "ags/gtk4"
import { MenuOption } from "./utils/menuOption"

const SUBMENU_MARGIN_LEFT = 5;
const SUBMENU_MARGIN_TOP = 10;
const COLORS = [
  "blue",
  // "brown",
  "green",
  "orange",
  "pink",
  "purple",
  "red",
  // "slate",
  "teal",
  "yellow"
]

const MENU_OPTIONS: Array<MenuOption> = [
  new MenuOption({
    label: "System Monitor",
    icon: "󰓅",
    action: async () => {
      await execAsync(["gnome-system-monitor"]).catch(console.error);
    }
  }),
  new MenuOption({
    label: "Files",
    icon: "",
    action: async () => {
      await execAsync(["nemo"]).catch(console.error);
    }
  }),
  new MenuOption({
    label: "Appearance",
    icon: "",
    submenu: [
      new MenuOption({
        label: "Change background",
        icon: "󰋩",
        action: async () => {
          await execAsync(["scripts/set_background.sh"]).catch(console.error);
        },
      }),
      new MenuOption({
        label: "Set mode",
        icon: "",
        submenu: [
          new MenuOption({
            label: "Auto",
            action: async () => {
              await execAsync(["scripts/set_mode.sh", "auto"]);
            },
            checkedCondition: async () => {
              const forceMode = await execAsync(["scripts/get_config_value.sh", "force_mode"]);
              return forceMode.trim() === "false";
            }
          }),
          new MenuOption({
            label: "Dark",
            icon: "",
            action: async () => {
              await execAsync(["scripts/set_mode.sh", "dark"]);
            },
            checkedCondition: async () => {
              const forceMode = await execAsync(["scripts/get_config_value.sh", "force_mode"]);
              if (forceMode.trim() === "true") {
                const currentMode = await execAsync(["scripts/get_config_value.sh", "mode"]);
                return currentMode.trim() === "dark";
              }
              return false;
            }
          }),
          new MenuOption({
            label: "Light",
            icon: "",
            action: async () => {
              await execAsync(["scripts/set_mode.sh", "light"]);
            },
            checkedCondition: async () => {
              const forceMode = await execAsync(["scripts/get_config_value.sh", "force_mode"]);
              if (forceMode.trim() === "true") {
                const currentMode = await execAsync(["scripts/get_config_value.sh", "mode"]);
                return currentMode.trim() === "light";
              }
              return false;
            }
          }),
        ],
        parentWindowName: `submenu-${new MenuOption({ label: "appearance", icon: "󰏘" }).getHash()}`
      }),
      new MenuOption({
        label: "Set color",
        icon: "",
        submenu: [
          new MenuOption({
            label: "Auto",
            action: async () => {
              await execAsync(["scripts/set_color.sh", "auto"]);
            },
            checkedCondition: async () => {
              const forceColor = await execAsync(["scripts/get_config_value.sh", "force_color"]);
              return forceColor.trim() === "false";
            }
          }),
          ...COLORS.map(color => new MenuOption({
            label: color[0].toUpperCase() + color.substring(1),
            action: async () => {
              await execAsync(["scripts/set_color.sh", color]);
            },
            checkedCondition: async () => {
              const forceColor = await execAsync(["scripts/get_config_value.sh", "force_color"]);
              if (forceColor.trim() === "true") {
                const currentColor = await execAsync(["scripts/get_config_value.sh", "color"]);
                return currentColor.trim() === color;
              }
              return false;
            }
          }))
        ],
        parentWindowName: `submenu-${new MenuOption({ label: "appearance", icon: "󰏘" }).getHash()}`
      }),
    ],
    parentWindowName: "main-menu"
  }),
  new MenuOption({
    isSeparator: true
  }),
  new MenuOption({
    label: "Power",
    icon: "",
    action: async () => {
      await execAsync(["scripts/cursor_middle.sh", "-plusX", "107"]).then(() => {
        app.toggle_window("power-menu");
      }).catch(console.error);
    }
  }),
];

// Prepare submenus and return them as windows
function setupSubmenus(submenuOptions: Array<MenuOption>, gdkmonitor: Gdk.Monitor, parentWindowName: string = "", marginLeft: number = 0, parentTopMargin: number = 0): void {
  submenuOptions.forEach((option, index) => {
    if (option.submenu) {
      const ENTRY_HEIGHT = 26;
      const SEPARATOR_HEIGHT = 1;
      const MENU_WIDTH = 185;
      // Calculate how many items are before this submenu
      let plusMargin = 0;
      for (let i = 0; i < index; i++) {
        if (submenuOptions[i].isSeparator) {
          plusMargin += SEPARATOR_HEIGHT;
        } else {
          plusMargin += ENTRY_HEIGHT;
        }
      }

      const submenuName = `submenu-${option.getHash()}`;
      const effectiveParentWindowName = option.parentWindowName || parentWindowName;
      const totalTopMargin = parentTopMargin + plusMargin;

      // Menu instance for submenu
      Menu(
        gdkmonitor,
        option.submenu!,
        {
          name: submenuName,
          parentWindowName: effectiveParentWindowName,
          plusMarginLeft: marginLeft == 0 ? (SUBMENU_MARGIN_LEFT + 1) : (SUBMENU_MARGIN_LEFT * 2 + 1 + marginLeft),
          plusMarginTop: SUBMENU_MARGIN_TOP + totalTopMargin
        }
      )

      // Recursively setup nested submenus
      setupSubmenus(option.submenu!, gdkmonitor, submenuName, MENU_WIDTH * 2, totalTopMargin);
    }
  });
}

app.start({
  css: style,
  main() {
    // TODO validate monitors

    app.get_monitors().map(Bar);
    app.get_monitors().map(PowerMenu);
    app.get_monitors().map((m) => Menu(m, MENU_OPTIONS, { plusMarginTop: SUBMENU_MARGIN_TOP, plusMarginLeft: SUBMENU_MARGIN_LEFT }));
    app.get_monitors().map((m) => {
      setupSubmenus(MENU_OPTIONS, m, "main-menu", 0, 0);
    });
  },
})
