{ ... }:

{
    imports = [
        ./desktop-environment
        ./programs
        ./shell
    ];

    home = {
        username = "lalie";
        homeDirectory = "/home/lalie";
        stateVersion = "25.11";
    };

    programs.home-manager.enable = true;
}
