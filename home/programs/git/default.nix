{ config, pkgs, ... }:

{
    programs.git = {
        enable = true;
        userName = "LalieA";
        userEmail = "83229713+LalieA@users.noreply.github.com";

        aliases = {
            co = "checkout";
            br = "branch";
            ci = "commit";
            st = "status";
            rb = "rebase";
            log = "log --all --graph --oneline --decorate";
        };
    };
}
