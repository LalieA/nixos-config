{ ... }:

{
    imports = [
        ../../home/programs/packages/base.nix
        ../../home/programs/packages/useful.nix
        ../../home/programs/packages/dev.nix
        ../../home/programs/direnv
        ./librewolf
        ./git
        ../../home/programs/vscode
    ];

    # Swappy configuration (screenshots)
    home.file.".config/swappy/config".source = ../../home/programs/swappy.conf;
}
