{ pkgs, ... }:
let
    waybarStyle = builtins.readFile "${pkgs.waybar}/etc/xdg/waybar/style.css";
in
{
    programs.waybar = {
        enable = true;
        systemd.enable = true;
        package = pkgs.waybar.overrideAttrs (oldAttrs: {
            mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        });

        style = ''
            ${builtins.replaceStrings ["#workspaces button.focused"] ["#workspaces button.active"] waybarStyle}

            #custom-notifications {
                padding: 0 10px;
            }

            #custom-notifications {
                background-color: #1f1f1f;
                color: #ffffff;
                font-family: "NotoSansMono Nerd Font";
            }
        '';

        settings = [{
            height = 30;
            layer = "top";
            position = "top";
            spacing = 4;

            modules-left = [
                "hyprland/workspaces"
            ];
            modules-center = [];
            modules-right = [
                "pulseaudio"
                "network"
                "cpu"
                "memory"
                "temperature"
                "backlight"
                "battery"
                "clock"
                "custom/notifications"
                "tray"
            ];

            "hyprland/workspaces" = {
                format = "{icon}";
                on-scroll-up = "hyprctl dispatch workspace e+1";
                on-scroll-down = "hyprctl dispatch workspace e-1";
                on-click = "activate";
                sort-by-number = true;
            };

            mpd = {
                format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ";
                format-disconnected = "Disconnected ";
                format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
                unknown-tag = "N/A";
                interval = 2;
                consume-icons = {
                    on = " ";
                };
                random-icons = {
                    off = "<span color=\"#f53c3c\"></span> ";
                    on = " ";
                };
                repeat-icons = {
                    on = " ";
                };
                single-icons = {
                    on = "1 ";
                };
                state-icons = {
                    paused = "";
                    playing = "";
                };
                tooltip-format = "MPD (connected)";
                tooltip-format-disconnected = "MPD (disconnected)";
            };

            clock = {
                tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
                format-alt = "{:%Y-%m-%d}";
            };

            cpu = {
                format = "{usage}% ";
                tooltip = false;
            };

            memory = {
                format = "{}% ";
            };

            temperature = {
                critical-threshold = 50;
                format = "{temperatureC}°C {icon}";
                format-icons = ["" "" ""];
            };

            backlight = {
                device = "acpi_video1";
                format = "{percent}% {icon}";
                format-icons = ["" "" "" "" "" "" "" "" ""];
            };

            battery = {
                states = {
                    good = 95;
                    warning = 30;
                    critical = 15;
                };
                format = "{capacity}% {icon}";
                format-charging = "{capacity}% ";
                format-plugged = "{capacity}% ";
                format-alt = "{time} {icon}";
                format-icons = ["" "" "" "" ""];
            };

            network = {
                format-wifi = "{essid} ({signalStrength}%) ";
                format-ethernet = "{ipaddr}/{cidr} ";
                tooltip-format = "{ifname} via {gwaddr} ";
                format-linked = "{ifname} (No IP) ";
                format-disconnected = "Disconnected ⚠";
                format-alt = "{ifname}: {ipaddr}/{cidr}";
            };

            pulseaudio = {
                format = "{volume}% {icon} {format_source}";
                format-bluetooth = "{volume}% {icon} {format_source}";
                format-bluetooth-muted = " {icon} {format_source}";
                format-muted = " {format_source}";
                format-source = "{volume}% ";
                format-source-muted = "";
                format-icons = {
                    headphone = "";
                    hands-free = "";
                    headset = "";
                    phone = "";
                    portable = "";
                    car = "";
                    default = ["" "" ""];
                };
                on-click = "pavucontrol";
            };

            "custom/notifications" = {
                layer = "bottom";
                tooltip = false;
                format = "{} {icon}";
                format-icons = {
                    notification = "<span foreground='red'><sup></sup></span>";
                    none = "";
                    dnd-notification = "<span foreground='red'><sup></sup></span>";
                    dnd-none = "";
                    inhibited-notification = "<span foreground='red'><sup></sup></span>";
                    inhibited-none = "";
                    dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
                    dnd-inhibited-none = "";
                };
                return-type = "json";
                exec-if = "which swaync-client";
                exec = "swaync-client -swb";
                on-click = "swaync-client -t -sw";
                on-click-right = "swaync-client -d -sw";
                escape = true;
            };

            tray = {
                spacing = 10;
            };
        }];
    };
}
