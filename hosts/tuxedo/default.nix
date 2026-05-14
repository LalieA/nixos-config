{ pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./system.nix

        ../../modules/niri.nix

        ../../modules/system/audio.nix
        ../../modules/system/bluetooth.nix
        ../../modules/system/intel-graphics.nix
        ../../modules/system/virtualization.nix
    ];

    networking.hostName = "nixos";
    system.stateVersion = "25.11";
}
