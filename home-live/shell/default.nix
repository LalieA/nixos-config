{ ... }:

{
    imports = [
        ../../home/shell/terminals
        ../../home/shell/zsh.nix
    ];

    home.sessionVariables = {
        EDITOR = "code";
        BROWSER = "librewolf";
        TERM = "xterm-kitty";
    };
}
