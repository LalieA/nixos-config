{ lib, ... }:

{
    imports = [
        ./desktop-environment
        ./programs
        ./shell
    ];

    home = {
        username = "live";
        homeDirectory = lib.mkForce "/home/live";
        stateVersion = "23.11";
    };

    programs.home-manager.enable = true;
}
