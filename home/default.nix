{ ... }:

{
    imports = [
        ./anyrun
        ./direnv
        ./hyprland
        ./programs
        ./shell
        ./swaylock
        ./swayidle
        ./swaync
        ./waybar
        ./wlogout
    ];

    home = {
        username = "lalie";
        homeDirectory = "/home/lalie";
        stateVersion = "23.11";
    };

    programs.home-manager.enable = true;
}
