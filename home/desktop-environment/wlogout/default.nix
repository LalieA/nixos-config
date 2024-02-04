{ pkgs, ... }:
    let lockCommand = "${pkgs.swaylock-effects}/bin/swaylock -f";
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
