import { Gtk } from "ags/gtk4";
import AstalTray from "gi://AstalTray";
import { createBinding, For } from "gnim";

// https://github.com/Aylur/ags/blob/main/examples/gtk4/simple-bar/Bar.tsx
export default function TrayIcons() {
    const tray = AstalTray.get_default()
    const items = createBinding(tray, "items")

    return (
        <box
            orientation={Gtk.Orientation.VERTICAL}
        >
            <For each={items}>
                {(item) => (
                    <button
                        class="transparentThenHoverFg"
                        onClicked={() => {
                            item.activate(0, 0);
                        }}
                    >
                        <image gicon={createBinding(item, "gicon")} />
                    </button>
                )}
            </For>
        </box>
    )
}