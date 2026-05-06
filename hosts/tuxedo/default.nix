{ pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./system.nix
        ../../modules/hyprland.nix
        ../../modules/audio.nix
        ../../modules/bluetooth.nix
        ../../modules/virtualization.nix
        ../../modules/kali-tools.nix
    ];

    system.stateVersion = "25.11";
}
