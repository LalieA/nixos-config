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

    system.stateVersion = "25.11";
}
