{ ... }:

{
    programs.firefox = {
        enable = true;
        profiles = {
            default = {
                id = 0;
                search.force = true;
                settings = builtins.fromJSON (builtins.readFile ./user.js);
            };
        };
    };
}
