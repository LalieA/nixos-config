{ config, pkgs, ...}:

{
    programs.zsh = {
        enable = true;
        shellAliases = {
            ll = "ls -l";
            update = "sudo nixos-rebuild switch";
        };
        autocd = true;
        dotDir = ".config/zsh";
        history.share = true;
        history.path = "${config.home.homeDirectory}/.zshistory";
    };
}