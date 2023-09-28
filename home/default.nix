{ ... }:

{
    imports = [
        ./anyrun
        ./hyprland
        ./programs
        ./shell
        ./swaync
        ./waybar
    ];

    home = {
        username = "lalie";
        homeDirectory = "/home/lalie";
        stateVersion = "23.05";
    };

    programs.home-manager.enable = true;
}
