{ ... }:

{
    imports = [
        ./anyrun
        ./hyprland
        ./programs
        ./shell
        ./swaylock
        ./swaync
        ./waybar
        ./wlogout
    ];

    home = {
        username = "lalie";
        homeDirectory = "/home/lalie";
        stateVersion = "23.05";
    };

    programs.home-manager.enable = true;
}
