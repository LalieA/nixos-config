{ config, pkgs, ...}:

{
    imports = [
        ./shell
        ./programs
    ];

    home = {
        username = "lalie";
        homeDirectory = "/home/lalie";
        stateVersion = "23.05";
    };

    programs.home-manager.enable = true;
}
