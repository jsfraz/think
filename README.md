# think

<!--
TODO calendar

TODO bluetooth manager

TODO notification bar

TODO KDE Connect alternative
-->

[![wakatime](https://wakatime.com/badge/user/992c0ad1-7dae-4115-9198-1ba533452d32/project/2ddec85d-539d-4e8c-977e-cbe926a8b17d.svg)](https://wakatime.com/badge/user/992c0ad1-7dae-4115-9198-1ba533452d32/project/2ddec85d-539d-4e8c-977e-cbe926a8b17d)

Rice for my Thinkpad T14 Gen 1 with most of the standard desktop features implemented in Sway(fx) environment. Enhaced and thinkpadish version of [elite](https://github.com/jsfraz/elite).

TODO new images

| | |
|:---:|:---:|
| ![Screenshot 1](images/1.png) | ![Screenshot 2](images/2.png) |
| ![Screenshot 3](images/3.png) | ![Screenshot 4](images/4.png) |
| ![Screenshot 5](images/5.png) | ![Screenshot 6](images/6.png) |

## Features

- **Dynamic theming** - Auto color generation from wallpaper using matugen
- **Light/Dark mode** - Auto switching based on time or manual control
- **9 accent colors** - Blue, green, orange, pink, purple, red, teal, yellow, or auto-detect
- **Custom status bar** - AGS bar with workspaces, tray, network, battery, clock, and RunCat animation
- **Rofi menus** - App launcher, settings, network, and power menu with blur
- **7 screensavers** - Matrix, pipes, aquarium, lavalamp, hollywood, train, or random
- **SwayFX enhancements** - Rounded corners and blur effects
- **Smart gaps and borders** - 10px gaps with smart border management
- **Night light** - Blue light filter based on location
- **Autoclick** - Auto-clicker with configurable interval
- **Keyboard layouts** - Switch keyboard layouts
- **Media controls** - Volume, brightness, and playback keys with SwayOSD
- **Screenshots** - Region capture with grim/slurp
- **Lock screen** - swaylock-effects with wallpaper and auto-lock
- **Background collection** - 1000+ GNOME wallpapers installer
- **GRUB theme** - HyperFluent theme for Arch
- **Plymouth theme** - Animated Arch boot splash
- **Floating rules** - For calculator, network manager, audio mixer, etc.
- **Custom config manager** - CLI tool for managing all settings

## Dependencies

- git
- [swayfx](https://github.com/WillPower3309/swayfx)
- [ags](https://github.com/Aylur/ags)
- [golang 1.25.5](https://go.dev/dl/)
- [jrch](jrch/README.md)
- [rofi-wayland](https://github.com/davatorium/rofi)
- [grimshot](https://sr.ht/~emersion/grim/) ([sway-contrib package](https://github.com/OctopusET/sway-contrib))
- [matugen](https://github.com/InioX/matugen)
- [FiraCode Nerd Font](https://www.nerdfonts.com)
- [AstalBattery](https://aylur.github.io/astal/guide/libraries/battery), [AstalTray](https://aylur.github.io/astal/guide/libraries/tray) [build troubleshooting](#AstalTray-troubleshoot), [AstalNetwork](https://aylur.github.io/astal/guide/libraries/network) (run `ags types` after installing)
- [sass](https://archlinux.org/packages/extra/x86_64/sassc/)
- [libnotify](https://gitlab.gnome.org/GNOME/libnotify)
- [mako](https://github.com/emersion/mako)
- [jq](https://github.com/jqlang/jq)
- [ydotool](https://github.com/ReimuNotMoe/ydotool)
- [btop](https://github.com/aristocratos/btop)
- [zenity-gtk3](https://aur.archlinux.org/packages/zenity-gtk3)
- [darkman](https://gitlab.com/WhyNotHugo/darkman)
- [nemo](https://github.com/linuxmint/nemo)
- [Orchis-theme](https://github.com/vinceliuice/Orchis-theme) (`./install.sh -t all -s compact`)
- [MoreWaita](https://github.com/somepaulo/MoreWaita)
- [Adwaita-colors](https://github.com/dpejoh/Adwaita-colors) (run `sudo ./morewaita.sh` after installing MoreWaita and Adwaita-colors)
- [python-pillow](https://pypi.org/project/pillow/) package
- [HyperFluent-GRUB-Theme (arch btw)](https://github.com/Coopydood/HyperFluent-GRUB-Theme) (installation below)
- [plymouth-theme-arch-logo](https://aur.archlinux.org/packages/plymouth-theme-arch-logo) (installation below)
- [alacritty](https://github.com/alacritty/alacritty)
- [starship](https://github.com/starship/starship)
- [fastfetch](https://github.com/fastfetch-cli/fastfetch)
- [swaylock-effects](https://github.com/mortie/swaylock-effects)
- [swayidle](https://github.com/swaywm/swayidle)
- [adobe-source-han-sans-jp-fonts](https://archlinux.org/packages/?name=adobe-source-han-sans-jp-fonts) (or any other japanese font of your choice)
- [foot](https://codeberg.org/dnkl/foot)
- [neo](https://github.com/st3w/neo)
- [pipes.sh](https://github.com/pipeseroni/pipes.sh)
- [cbonsai](https://gitlab.com/jallbrit/cbonsai)  TODO implement
- [asciiquarium](https://github.com/cmatsuoka/asciiquarium)
- [lavat](https://github.com/AngelJumbo/lavat)
- [holywood](https://github.com/dustinkirkland/hollywood)
- [sl](https://archlinux.org/packages/extra/x86_64/sl/)
- [networkmanager-dmenu](https://github.com/firecat53/networkmanager-dmenu)
- [nm-connection-editor](https://archlinux.org/packages/?name=nm-connection-editor)
- [networkmanager-openvpn](https://archlinux.org/packages/?name=networkmanager-openvpn) (with `libnma-gtk4` and `libnma` [packages](https://wiki.archlinux.org/title/NetworkManager#OpenVPN_connections_fail_with_%22secrets:_failed_to_request_VPN_secrets%22_warn))
- [wlsunset](https://sr.ht/~kennylevinsen/wlsunset/)
- [qalculate-gtk](https://github.com/Qalculate/qalculate-gtk)
- [SwayOSD](https://github.com/ErikReider/SwayOSD) (run `sudo systemctl enable --now swayosd-libinput-backend.service` after installing)
- [brightnessctl](https://github.com/Hummer12007/brightnessctl)
- [pavucontrol](https://archlinux.org/packages/extra/x86_64/pavucontrol/)

## swayfx

To start `swayfx` on login, add this to `~/.bash_profile`:

```bash
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
  exec sway
fi
```

### [Autologin](https://wiki.archlinux.org/title/Getty#Automatic_login_to_virtual_console)

Create a drop-in file `/etc/systemd/system/getty@tty1.service.d/autologin.conf` for `getty@tty1.service`:

```service
[Service]
ExecStart=
ExecStart=-/sbin/agetty --noreset --noclear --autologin username - ${TERM}
```

Make sure to replace `username` with your actual username.

### Linking config

```bash
ln -sf $PWD/.config/sway ~/.config/sway
```

### Installing backgrounds

Download all the [GOOD](https://zebreus.github.io/all-gnome-backgrounds/) backgrounds from [all-gnome-backgrounds](https://github.com/zebreus/all-gnome-backgrounds) using this command:

```bash
./install_all_gnome_backgrounds.sh
```

## ags

> [!NOTE]
> If you run into this error: `can not initialize layer shell on window: layer shell not supported
tip: running from an xwayland terminal can cause this, for example VsCode` you need to run this in a native wayland terminal like `alacritty` or `foot`.

### Linking config

```bash
rm ~/.config/ags
ln -sf $PWD/.config/ags ~/.config/ags
ags types
```

### Starting manually

When starting `ags` manually, make sure the `GI_TYPELIB_PATH` includes the path to `AstalBattery` typelib:

```bash
export GI_TYPELIB_PATH=$(dirname $(find /usr -name "*AstalBattery*.typelib" 2>/dev/null)):$GI_TYPELIB_PATH
ags run
```

This is done automatically when using provided `sway` config.

## jrch

A tool for managing SwayWM rice environment configuration.

### Installing jrch
To install `jrch`, run the following command:

```bash
./install_jrch.sh
```

## matugen

`matugen` is used to generate SCSS files for other programs based on the current background image.

You need to install [python-pillow](https://pypi.org/project/pillow/) package and install and configure [darkman](#darkman) for custom scripts to work.

### Linking config

```bash
ln -sf $PWD/.config/matugen ~/.config/matugen
```

### Generating color schemes manually

To run some program you need to generate color schemes using `matugen`:

```bash
matugen image <image_path> -m <dark|light>
# or using this rice background config
BACKGROUND_FILE=$(jrch get background)
matugen image $BACKGROUND_FILE -m <dark|light>
```

## alacritty

### Linking config

```bash
ln -sf $PWD/.config/alacritty ~/.config/alacritty
```

## fastfetch

To start `fastfetch` when opening terminal, add this to `~/.bashrc`:

```bash
if [ ! "$(tty)" = "/dev/tty1" ]; then
  clear
  echo
  fastfetch
fi
```

# starship

Add the following to the end of ~/.bashrc:

```bash
eval "$(starship init bash)"
```

## btop

After generating theme using `matugen`, choose it from `btop` settings.

## rofi

### Linking config

```bash
ln -sf $PWD/.config/rofi ~/.config/rofi
ln -sf $PWD/.config/networkmanager-dmenu ~/.config/networkmanager-dmenu
```

## ydotool

You need to run `ydotool` deamon as root to use the autoclicker. Create a systemd service file at `/etc/systemd/system/ydotool.service` with

```bash
[Unit]
Description=Starts ydotoold service

[Service]
Type=simple
Restart=always
ExecStart=ydotoold --socket-path="/tmp/.ydotool_socket" --socket-own="1000:1000"
ExecReload=kill -HUP $MAINPID
KillMode=process
TimeoutSec=180

[Install]
WantedBy=default.target
```

Then enable and start the service:

```bash
sudo systemctl daemon-reload
sudo systemctl enable ydotool.service
sudo systemctl start ydotool.service
```

## darkman

To manage dark/light themes automatically based on the time of day.

### Linking config

```bash
ln -sf $PWD/.config/darkman ~/.config/darkman
ln -sf $PWD/.local/share/darkman ~/.local/share/darkman
```

You can edit `lat` and `lng` in `~/.config/darkman/config.yml`.

After installing and creating config, enable the user service:

```bash
systemctl --user enable --now darkman.service
```

## HyperFluent-GRUB-Theme
To install the HyperFluent GRUB theme, run the following command:

```bash
./install_grub_theme.sh
```

## plymouth-theme-arch-logo

To install the Plymouth Arch Logo theme, run the following command:

```bash
./install_plymouth_theme.sh
```

## Credits

Inspired by [Ateon](https://github.com/Youwes09/Ateon) ([reddit](https://www.reddit.com/r/unixporn/comments/1o0yhvq/hyprland_my_nefarious_system/)), [Freosan](https://github.com/namishh/crystal/tree/freosan) ([reddit](https://www.reddit.com/r/unixporn/comments/1as3fw8/swayfx_freosan/)) and [gnome-runcat](https://github.com/win0err/gnome-runcat). Some assets/code borrowed from Ateon, gnome-runcat, [adi1090x/rofi](https://github.com/adi1090x/rofi/), [InioX/matugen-themes](https://github.com/InioX/matugen-themes).

## AstalTray troubleshoot

### `meson.build:44:2: ERROR: Dependency "appmenu-glib-translator" not found, tried pkgconfig and cmake`

```bash
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
```

### `Failed to load shared library '/usr/local/lib/libastal-tray.so.0.1.0' referenced by the typelib: libappmenu-glib-translator.so.0: shared object file cannot be opened: Directory or file does not exist`

Put his line at the end of the `/etc/ld.so.conf.d/local.conf` file:

```
/usr/local/lib
```

and run `sudo ldconfig`.

<!-- yeah -->
<p align="center">
  <img src="https://github.com/Coopydood/ultimate-macOS-KVM/assets/39441479/39d78d4b-8ce8-44f4-bba7-fefdbf2f80db" width="10%"> </img>
</p>