{ ... }:

{
    imports = [
        ./terminals
        ./zsh.nix
    ];

    home.sessionVariables = {
        EDITOR = "code";
        BROWSER = "firefox";
        TERM = "xterm-kitty";
    };
}
