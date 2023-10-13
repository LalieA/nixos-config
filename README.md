# ❄️ NixOS setup with flakes ❄️
> Tuxedo InfinityBook Pro 14 (8th generation)

There are still a lot of things to do to make NixOS my everyday system, but I'm working on it.

## What has been done
- Use the default GNOME/Wayland environment provided by NixOS's official ISO image
-  Switch to Hyprland Wayland compositor with waybar, hyprpaper and swaylock
- Deploy in a VirtualBox Virtual Machine
- Setup a general environment:
  - Configured shell environments Kitty, Alacritty and zsh
  - Configured programs such as git, vscode (with extensions), firefox (with extensions)
- Hard install on my Tuxedo 💻
  - Made a working Hyprland configuration with some i3 and function keys bindings
  - Add TUXEDO Control Center

## What's planned
- Continue various configurations:
  - Enable and test Bluetooth
  - Enable and test HDMI and USB-C external screens
  - Enable and test screen video streaming for Zoom-like softwares
  - Enable and test webcam
  - Enable and test microphone
- Add security-related features and secret handling : SSH keys, known SSH hosts, PGP key for signed commits, ...

## In the future
- Setup development environments
- See if a Yubikey could act as the master key for secrets encryption/decryption. It could also be interesting to take a look at LUKS full disk encryption with such a key.

> These are my first steps with Nix, NixOS and flakes, be kind please I am suffering
