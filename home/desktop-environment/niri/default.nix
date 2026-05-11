{ pkgs, lib, inputs, config, ... }:

{
    imports = [ inputs.niri.homeModules.niri ];

    programs.niri = {
        enable = true;
        package = pkgs.niri; # get Niri from nixpkgs

        settings = {
            # Misc
            prefer-no-csd = true;
            screenshot-path = "${config.xdg.userDirs.pictures}/Screenshots/%Y-%m-%d--%H-%M-%S.png";
            clipboard.disable-primary = true;
            hotkey-overlay.skip-at-startup = true;

            # Inputs
            input = {
                mod-key = "Super";

                keyboard = {
                    xkb = {
                        layout = "fr";
                        variant = "azerty";
                    };
                    track-layout = "window";
                    repeat-delay = 600;
                    repeat-rate = 25;
                };

                touchpad = {
                    natural-scroll = true;
                    scroll-method = "two-finger";
                    dwt = true;
                    click-method = "button-areas";
                    scroll-factor = 0.5;
                };

                focus-follows-mouse = {
                    max-scroll-amount = "10%";
                };
            };

            # Outputs
            outputs = {
                "eDP-1" = {
                    position = {
                        x = 0;
                        y = 0;
                    };
                    focus-at-startup = true;
                };
                "HDMI-A-1" = {
                    position = {
                        x = 0;
                        y = -1080;
                    };
                };
            };

            # Overview
            overview = {
                zoom = 0.5;
                workspace-shadow = {
                    enable = true;
                    softness = 40;
                    spread = 10;
                    offset = {
                        x = 0;
                        y = 10;
                    };
                    color = "#00000050";
                };
            };

            # XWayland
            xwayland-satellite = {
                enable = true;
                path = "${lib.getExe pkgs.xwayland-satellite}";
            };

            # Spawned at startup
            spawn-at-startup = [ ];

            # Binds
            binds = {
                "Mod+Return".action.spawn = "kitty";
                "Mod+A".action.spawn = "code";
                "Mod+Z".action.spawn = "firefox";

                "Mod+Shift+Q".action.close-window = {};
                "Mod+F".action.maximize-column = {};
                "Mod+Shift+F".action.fullscreen-window = {};
                "Mod+D".action.spawn = [ "dms" "ipc" "call" "spotlight" "toggle" ];
                "Mod+L".action.spawn = [ "dms" "ipc" "call" "lock" "lock" ];
                # "Mod+Shift+E" = {  }; # TODO: logout, reboot, power off screen

                "Mod+Left".action.focus-column-left = {};
                "Mod+Right".action.focus-column-right = {};
                "Mod+Up".action.focus-workspace-up = {};
                "Mod+Down".action.focus-workspace-down = {};

                "Mod+Shift+Left".action.move-column-left = {};
                "Mod+Shift+Right".action.move-column-right = {};
                "Mod+Shift+Up".action.move-column-to-workspace-up = {};
                "Mod+Shift+Down".action.move-column-to-workspace-down = {};

                "Mod+ampersand".action.focus-monitor-left = {};
                "Mod+eacute".action.focus-monitor-up = {};
                "Mod+quotedbl".action.focus-monitor-down = {};
                "Mod+apostrophe".action.focus-monitor-right = {};
                "Mod+Shift+ampersand".action.move-window-to-monitor-left = {};
                "Mod+Shift+eacute".action.move-window-to-monitor-up = {};
                "Mod+Shift+quotedbl".action.move-window-to-monitor-down = {};
                "Mod+Shift+apostrophe".action.move-window-to-monitor-right = {};

                "Mod+Tab".action.toggle-overview = {};
                "Mod+V".action.toggle-window-floating = {};
                "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = {};
                "Print".action.screenshot = {};

                "XF86MonBrightnessDown" = { # F1 - brightness down
                    allow-when-locked = true;
                    action.spawn = [ "dms" "ipc" "call" "brightness" "decrement" "5" ];
                };
                "XF86MonBrightnessUp" = { # F2 - brightness up
                    allow-when-locked = true;
                    action.spawn = [ "dms" "ipc" "call" "brightness" "increment" "5" ];
                };
                "XF86AudioMute" = { # F6 - mute volume & microphone
                    allow-when-locked = true;
                    action.spawn = [ "dms" "ipc" "call" "audio" "mute" ];
                };
                "XF86AudioLowerVolume" = { # F7 - volume down
                    allow-when-locked = true;
                    action.spawn = [ "dms" "ipc" "call" "audio" "decrement" "5" ];
                };
                "XF86AudioRaiseVolume" = { # F8 - volume up
                    allow-when-locked = true;
                    action.spawn = [ "dms" "ipc" "call" "audio" "increment" "5" ];
                };
            };

            # Layout
            ## Overrided by DMS
            layout = {
                gaps = 1;
                center-focused-column = "always";
                always-center-single-column = true;
                empty-workspace-above-first = true;
                default-column-width = { proportion = 0.49; };
                border = {
                    enable = true;
                    width = 1;
                    active.color = "#cba6f7";
                    inactive.color = "#313244";
                    urgent.color = "#f38ba8";
                };

                focus-ring = {
                    enable = true;
                    width = 1;
                };

                shadow = {
                    enable = true;
                    softness = 10;
                    spread = 10;
                    draw-behind-window = true;
                };

                background-color = "transparent";
            };

            # Rules
            layer-rules = [ { } ];

            # Animations
            animations = { };

            # Environment
            environment = {
                "XDG_CURRENT_DESKTOP" = "niri";
                "QT_QPA_PLATFORM" = "wayland";
                "ELECTRON_OZONE_PLATFORM_HINT" = "auto";
                "QT_QPA_PLATFORMTHEME" = "gtk3";
                "QT_QPA_PLATFORMTHEME_QT6" = "gtk3";
            };
        };
    };
}
