{ ... }:

{
    imports = [
        ./zsh.nix
    ];

    home.sessionVariables = {
        EDITOR = "code";
        BROWSER = "firefox";
        TERM = "xterm-kitty";
    };

    programs.kitty.enable = true;
}
