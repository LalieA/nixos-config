{ ... }:

{
    programs.git = {
        enable = true;

        aliases = {
            co = "checkout";
            br = "branch";
            ci = "commit";
            st = "status";
            rb = "rebase";
            log = "log --all --graph --oneline --decorate";
        };

        extraConfig = {
            core = {
                editor = "code --wait";
            };
            diff = {
                tool = "default-difftool";
            };
            difftool.default-difftool.cmd = "code --wait --diff $LOCAL $REMOTE";
            merge = {
                tool = "default-mergetool";
            };
            mergetool.default-mergetool.cmd = "code --wait $MERGED";
        };
    };
}
