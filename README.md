# ❄️ NixOS setup with flakes ❄️

> 💻 Tuxedo InfinityBook Pro 14 (8th generation)

NixOS is now my everyday system, I hope this repository will help you build yours!

## Main configuration

| | |
| ------------: | :------ |
| **NixOS release** | **25.11** |
| **Display Manager** | [GDM](https://wiki.archlinux.org/title/GDM) |
| **Window Manager/Compositor** | [Niri](https://niri-wm.github.io/niri/) (Wayland) |
| **Desktop** | [Dank Material Shell](https://danklinux.com/) |
| **Terminal Emulators** | [kitty](https://sw.kovidgoyal.net/kitty/) |
| **Shell** | [zsh](https://wiki.archlinux.org/title/zsh) + [powerlevel10k](https://github.com/romkatv/powerlevel10k) |


## How to install and manage system configuration with Git

Git handles very well text files such as NixOS configuration ones; I strongly suggest you to use it to keep track of the changes you made and for easy rollback.

The system's configuration is located by default in `/etc/nixos`.
As it is a root directory, it is not practical to initialize a Git repository directly in this folder.
What could be done is making this directory a symbolic link to a more user friendly one.

<details>
<summary><strong>Backup your current configuration</strong></summary>

```bash
sudo mv /etc/nixos /etc/nixos-old
```
</details>

<details>
<summary><strong>Download this configuration...</strong></summary>

```bash
cd ~/Documents && git clone git@github.com:LalieA/nixos-config.git
```
</details>

<details>
<summary><strong>... or initialize yours</strong></summary>

```bash
cd ~/Documents/nixos-config
cp -R /etc/nixos-old/* .
git init
```
</details>

<details>
<summary><strong>Create a symbolic link from your friendly directory</strong></summary>

```bash
sudo ln -s ~/Documents/nixos-config /etc/nixos
```
</details>

<details>
<summary><strong>And deploy your configuration!</strong></summary>

```bash
sudo nixos-rebuild switch
```
</details>

## How this configuration is built

```
                      (3)   ┌──────────┐ (4)
                     ┌─────►│./home.nix├────┐
                     │      └──────────┘    ▼
┌─────────┐ (1) ┌────┴───┐                ┌──────────────────────────────────────┐
│flake.nix├────►│hive.nix│                │./modules/{,system,packages,...}/_.nix│
└─────────┘     └────┬───┘                └──────────────────────────────────────┘
                     │    ┌─────────────┐   ▲
                     └───►│./hosts/_.nix├───┘
                      (2) └─────────────┘(4)
```

This configuration is designed to keep NixOS configurations that define hardware, system, and user-specific settings as separate as possible.
Machine and user configurations are linked together in the `hive.nix` file **(1)**, which is used by [Colmena](https://github.com/zhaofengli/colmena) to facilitate the deployment of a NixOS configuration locally and on remote machines. This also makes the `flake.nix` file lighter.
Configuration options specific to the machine on which NixOS is to be deployed are defined in files within the `./hosts` directory **(2)**, while desktop environments and user packages are defined in `./home*` directories **(3)**.
Finally, common features such as audio configuration, Bluetooth, or Intel iGPUs will often require the same options and services to be enabled and are therefore described in files under `./modules` **(4)**. This helps limit the number of lines of code that need to be duplicated for similar functions across two NixOS systems that include them.


```
/
├── home/
│   ├── desktop-environment/
│   ├── programs/
│   ├── shell/
│   ├── ...
│   └── default.nix --> includes from ./modules/packages
├── hosts/
│   ├── tuxedo/
│   │   ├── hardware-configuration.nix --> hardware-specific configuration (e.g. CPU microcode, kernel modules)
│   │   ├── system.nix --> system-specific configuration (e.g. locales, fonts, network)
│   │   ├── ...
│   │   └── default.nix --> includes from ./modules/system
│   └── ...
├── modules/
│   ├── packages/ --> pre-made lists of useful programs
│   │   ├── base.nix
│   │   ├── desktop.nix
│   │   ├── dev.nix
│   │   ├── kali.nix --> packages provided in Kali Linux images
│   │   └── ...
│   ├── system/
│   │   ├── audio.nix
│   │   ├── bluetooth.nix
│   │   ├── intel-graphics.nix
│   │   ├── virtualization.nix
│   │   └── ...
│   └── ...
├── flake.nix --> includes configs from hive.nix
└── hive.nix --> defines complete NixOS configs from ./hosts and ./home
```

## Going further with Colmena

[Colmena](https://github.com/zhaofengli/colmena) is a great tool to manage multiple NixOS deployments with a stateless tool.
The configuration in this repository can be updated in two ways, for a local NixOS system:

```bash
# the classic NixOS way
sudo nixos-rebuild switch

# or with Colmena
sudo colmena apply-local [--impure] [--verbose]
```

If another configuration has to be defined for a remote machine, it can be done in `hive.nix`:

```nix
### DEPLOYMENTS ###
...
"computer-hostname" = {
    networking.hostName = "computer-hostname";
    imports = [
        # NixOS host
        ./hosts/new-computer

        # Users
        home-manager.nixosModules.home-manager {
            home-manager.users."new-user" = import ./new-home;
        }
    ];
    deployment = {
        targetHost = <computer-ip>;
        targetPort = <computer-ssh-port>; # Don't forget to add your ssh key to be able to connect
        targetUser = "root";
    };
};
...
```
If necessary, create configuration files in `./hosts/new-computer` and `./new-home` based on your target.
Then, deploy the newly setup NixOS configuration:

```bash
sudo colmena apply --on <computer-hostname> [--impure] [--verbose]
```

For more information about what can Colmena do, especially for secret management, take a look at the [official documentation](https://colmena.cli.rs/unstable/).


## Create ISO for first installation

A minimal NixOS ISO image with only sshd can be generated for live or net boot purposes:

```bash
# Generate ISO
nix build .#nixosConfigurations.iso.config.system.build.isoImage

# Burn ISO to USB key -- check /dev/sdX
sudo dd if=./result/iso/nixos-live-minimal.iso of=/dev/sdX bs=1M status=progress oflag=sync
```

By setting the correct SSH public key for remote connection in `./hosts/live-minimal/system.nix`, you should be able to install a complete NixOS configuration using [nixos-anywhere](https://github.com/nix-community/nixos-anywhere) and tools like [Disko](https://github.com/nix-community/disko) for disk paritioning, then perform further updates through Colmena as usual.
This step replaces the need for a classical NixOS installation that can be time-consuming for some needs.


## What has been tested

- Wifi
- Bluetooth
- Integrated camera
- Integrated microphone
- Screen streaming through web-based video conferences
- Multi-screen (built-in HDMI and 2 screens through USB-C)

## What's planned in the future

- Handle secrets with [sops-nix](https://github.com/Mic92/sops-nix)...
- ... and setup a LUKS fully encrypted disk...
- ... with master keys from a YubiKey
- Still improve this configuration while using it

> To make my first steps into Nix and NixOS, I followed [the awesome guide from ryan4yin](https://nixos-and-flakes.thiscute.world/introduction/), don't hesitate to check it out!
