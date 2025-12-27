import { Gtk } from "ags/gtk4";
import { execAsync } from "ags/process";
import { createPoll } from "ags/time";
import { With } from "gnim";

const currentWorkspace = createPoll<string>("0", 100, async () => {
    try {
        // https://gist.github.com/Sprit3Dan/bb730c9405d4632cc90a1d36b5400207
        const output = await execAsync('bash -c "swaymsg -t get_workspaces | jq -r \'.[] | select(.focused==true) | .num\'"');
        return output.trim();
    } catch (error) {
        console.error(error);
        return "0";
    }
});

export default function Workspace() {
    return (
        <box
            class="Workspace"
            orientation={Gtk.Orientation.VERTICAL}
            halign={Gtk.Align.CENTER}
        >
            <stack
                transitionDuration={200}
                transitionType={Gtk.StackTransitionType.SLIDE_LEFT_RIGHT}
                $={(self) => (
                    <With value={currentWorkspace}>
                        {(workspace) => {
                            self.visibleChildName = workspace ?? "0";
                            return null;
                        }}
                    </With>
                )}
            >
                {Array.from({ length: 10 }, (_, i) => (
                    <label
                        $type="named"
                        name={(i + 1).toString()}
                        label={(i + 1).toString()}
                        halign={Gtk.Align.CENTER}
                    />
                ))}
            </stack>
        </box>
    );
}