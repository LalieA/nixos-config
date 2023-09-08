{ config, pkgs, ... }:

{
    imports = [
        ./common.nix
        ./firefox
        ./git
        ./vscode
    ];
}