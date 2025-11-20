import { execAsync } from "ags/process";

interface NotifyOptions {
    summary: string;
    body: string;
    iconName: "dialog-information" | "dialog-warning" | "dialog-error" | "battery-low" | "battery-full-charged";
    urgency: "low" | "normal" | "critical";
}

// Send a desktop notification using notify-send
export async function notify(options: NotifyOptions): Promise<void> {
    // TODO Use Astal lib
    await execAsync([
        "notify-send",
        options.summary,
        options.body,
        "-i", options.iconName,
        "-u", options.urgency,
    ]).catch(console.error);
}
