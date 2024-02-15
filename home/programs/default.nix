{ ... }:

{
    imports = [
        ./packages/base.nix
        ./packages/useful.nix
        ./packages/dev.nix
        ./packages/misc.nix
        ./direnv
        ./firefox
        ./git
        ./vscode
    ];

    # Auto-mount USB drives
    services.udiskie = {
        enable = true;
        notify = true;
    };

    # Swappy configuration (screenshots)
    home.file.".config/swappy/config".source = ./swappy.conf;
}
