{ ... }:

{
    imports = [
        ./desktop-environment
        ./programs
        ./shell

        ../modules/packages/base.nix
        ../modules/packages/desktop.nix
        ../modules/packages/dev.nix
        ../modules/packages/games.nix
        ../modules/packages/kali.nix
        ../modules/packages/misc.nix
    ];

    home = {
        username = "lalie";
        homeDirectory = "/home/lalie";
        stateVersion = "25.11";
    };

    # Use XDG user directories
    xdg.userDirs.enable = true;

    programs.home-manager.enable = true;
}
