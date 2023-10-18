{ pkgs, ... }:
    let lockCommand = "${pkgs.swaylock-effects}/bin/swaylock -f -i ~/.config/hypr/wallpaper.jpg --clock --indicator --indicator-radius 100 --indicator-thickness 15 --effect-blur 10x5 --text-color ffffff --show-failed-attempts";
in
{
    programs.wlogout = {
        enable = true;
        layout = [
        {
            label = "lock";
            action = lockCommand;
            text = "Lock";
            keybind = "a";
        }
        {
            label = "reboot";
            action = "systemctl reboot";
            text = "Reboot";
            keybind = "z";
        }
        {
            label = "shutdown";
            action = "systemctl poweroff";
            text = "Shutdown";
            keybind = "e";
        }
        ];
    };
}
