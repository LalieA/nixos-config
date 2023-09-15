{ config, pkgs, lib, ... }:

{
    imports = [
        ./shell
        ./programs
        ./hyprland
    ];

    home = {
        username = "lalie";
        homeDirectory = "/home/lalie";
        stateVersion = "23.05";
    };

    programs.home-manager.enable = true;
}
