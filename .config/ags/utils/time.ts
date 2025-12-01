import { createPoll } from "ags/time";

export const currentTimeString = createPoll<string>("00:00:00", 200, () => {
  const now = new Date();
  const hh = now.getHours().toString().padStart(2, "0");
  const mm = now.getMinutes().toString().padStart(2, "0");
  const ss = now.getSeconds().toString().padStart(2, "0");
  return `${hh}:${mm}:${ss}`;
});

export function getCurrentDateString(): string {
  const now = new Date();
  return now.toLocaleDateString(undefined, {
    day: 'numeric',
    month: 'long',
    year: 'numeric'
  });
}