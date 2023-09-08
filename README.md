# NixOS configuration
> ❄️ NixOS setup with flakes ❄️

There are still a lot of things to do to make NixOS my everyday system, but I'm working on it.

## What I'm currently working on
- Create a working modular project
- Deploy in a VirtualBox Virtual Machine
- Setup a general environment:
  - Configured shell environments such as Kitty/Alacritty and zsh+oh-my-zsh
  - Configured programs such as git, vscode, firefox
- Use the default GNOME environment provided by NixOS's official ISO image
- Add security-related features like GPG and signed git commits. Also find a way to handle secrets.

## What's planned
- Move to Wayland instead of Xorg
  - Hyprland window manager
  - Waybar (?)
  - Anyrun (?)
  - PCManFM (?)
- Finally hard install on my Tuxedo 💻
  - Add kernel headers for TUXEDO Control Center and install it
  - Enable and test Bluetooth
  - Enable and test HDMI and USB-C external screens
  - Enable and test screen video streaming for Zoom-like softwares
  - Enable and test webcam
  - Enable and test microphone
  - Install trackpad drivers if necessary
  - Setup function keys (brightness, performance, sound control, plane mode, sleep mode, keyboard backlit, ...)

> These are my first steps with Nix, NixOS and flakes, be kind please I am suffering
