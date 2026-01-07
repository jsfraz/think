import { Gdk } from "ags/gtk4";
import Network from "gi://AstalNetwork";
import { createBinding } from "gnim";

const network = Network.get_default();

export default function NetworkIndicator() {
    const getTooltipText = () => {
        const primary = network.primary;
        
        if (primary === Network.Primary.WIFI && network.wifi) {
            const wifi = network.wifi;
            const strength = Math.round(wifi.strength);
            return `${strength}%`;
        } else if (primary === Network.Primary.WIRED && network.wired) {
            const wired = network.wired;
            const speed = wired.speed;
            return speed > 0 ? `${speed} Mb/s` : "? Mb/s";
        }
        
        return "No connection";
    };

    const getIconName = () => {
        const primary = network.primary;
        
        if (primary === Network.Primary.WIFI && network.wifi) {
            return network.wifi.iconName;
        } else if (primary === Network.Primary.WIRED && network.wired) {
            return network.wired.iconName;
        }
        
        return "network-offline-symbolic";
    };

    return (
        <button
            class="NetworkIndicator transparentThenHoverFg"
            cursor={Gdk.Cursor.new_from_name("pointer", null)}
            tooltipText={createBinding(network, "primary")(() => getTooltipText())}
        >
            <image
                // @ts-ignore
                iconName={createBinding(network, "primary")(() => getIconName())}
            />
        </button>
    );
}