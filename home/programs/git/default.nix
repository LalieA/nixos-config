{ ... }:

{
    programs.git = {
        enable = true;
        settings = {
            user = {
                name = "LalieA";
                email = "83229713+LalieA@users.noreply.github.com";
            };
            alias = {
                co = "checkout";
                br = "branch";
                ci = "commit";
                st = "status";
                rb = "rebase";
                log = "log --all --graph --oneline --decorate";
            };
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
