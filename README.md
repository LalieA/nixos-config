# ❄️ NixOS setup with flakes ❄️
> 💻 Tuxedo InfinityBook Pro 14 (8th generation)

NixOS is now my everyday system, I hope this repository will help you build yours!

## Configuration

| | |
| ------------: | :------ |
| **NixOS release** | **23.05** |
| **Display Manager** | [GDM](https://wiki.archlinux.org/title/GDM) |
| **Window Manager/Compositor** | [Hyprland](https://hyprland.org/) (Wayland) |
| **Status bar** | [Waybar](https://github.com/Alexays/Waybar) |
| **Wallpaper Manager** | [hyprpaper](https://github.com/hyprwm/hyprpaper) |
| **App Launcher**    | [anyrun](https://github.com/Kirottu/anyrun) |
| **Notification Center** | [swaync](https://github.com/ErikReider/SwayNotificationCenter) |
| **Screen Locker** | [swaylock-effects](https://github.com/mortie/swaylock-effects) |
| **Logout & Power Menu** | [wlogout](https://github.com/ArtsyMacaw/wlogout) |
| **IDLE Manager** | [swayidle](https://github.com/swaywm/swayidle) |
| **Network Manager** | [NetworkManager](https://wiki.archlinux.org/title/NetworkManager) |
| **Terminal Emulators** | [kitty](https://sw.kovidgoyal.net/kitty/), [Alacritty](https://github.com/alacritty/alacritty) |
| **Shell** | [zsh](https://wiki.archlinux.org/title/zsh) + [powerlevel10k](https://github.com/romkatv/powerlevel10k) |
| **Editor** | [Visual Studio Code](https://code.visualstudio.com/) |
| **File Browser** | [PCManFM](https://wiki.archlinux.org/title/PCManFM) |
| **Snapshot & Editing** | [swappy](https://github.com/jtheoof/swappy) |
| **Miscellaneous** | [TUXEDO Control Center](https://www.tuxedocomputers.com/en/TUXEDO-Control-Center.tuxedo), NetworkManager & Blueman applets, git, ...|

## How to install and how to manage system's configuration with git

Git handles very well text files such as NixOS configuration ones; I strongly suggest you to use it to keep track of the changes you made and for easy rollback.

The system's configuration is located by default in `/etc/nixos`.
As it is a root directory, it is not practical to initialize a git repository directly in this folder.
What could be done is making this directory a symbolic link to a more user friendly one.

<details>
<summary><strong>Backup your current configuration</strong></summary>

```
sudo mv /etc/nixos /etc/nixos-old
```
</details>

<details>
<summary><strong>Download this configuration...</strong></summary>

```
cd ~/Documents && git clone git@github.com:LalieA/nixos-config.git
```
</details>

<details>
<summary><strong>... or initialize yours</strong></summary>

```
cd ~/Documents/nixos-config
cp -R /etc/nixos-old/* .
git init
```
</details>

<details>
<summary><strong>Create a symbolic link from your friendly directory</strong></summary>

```
sudo ln -s ~/Documents/nixos-config /etc/nixos
```
</details>

<details>
<summary><strong>And deploy your configuration!</strong></summary>

```
sudo nixos-rebuild switch
```
</details>

## What has been tested
- Wifi
- Bluetooth
- Integrated camera
- Integrated microphone
- Screen streaming through web-based video conferences
- Multi-screen (built-in HDMI and through USB-C)

## What's planned in the future
- Try to embed this configuration into an ISO image, for live and/or installation on another device
- Handle secrets with [sops-nix](https://github.com/Mic92/sops-nix)...
- ... and setup a LUKS fully encrypted disk...
- ... with master keys from a YubiKey
- Still improve this configuration while using it

> To make my first steps into Nix and NixOS, I followed [the awesome guide from ryan4yin](https://nixos-and-flakes.thiscute.world/introduction/), don't hesitate to check it out!
