{ inputs, pkgs, pkgs-unstable, ... }:
let
    configDir = "~/.config/niri/dms";
    configFiles = "${configDir}/{colors,layout,alttab,binds}.kdl";
    initScript = pkgs.writers.writeBash "init-dms" ''
        set -efu

        mkdir -p ${configDir}

        if [[ ! -f ${configFiles} ]]; then
            touch ${configFiles}
        fi
    '';
in
{
    imports = [
        inputs.dms.homeModules.dank-material-shell
        inputs.dms.homeModules.niri
        inputs.dms-plugins.modules.default
        inputs.danksearch.homeModules.dsearch
    ];

    programs.dank-material-shell = {
        enable = true;
        dgop.package = pkgs-unstable.dgop;
        quickshell.package = pkgs-unstable.quickshell;

        niri = {
            enableSpawn = false;
            includes = {
                enable = true;
                override = true;
            };
        };

        # Overrides DMS config file, which makes settings unwritable at runtime.
        ## See https://github.com/AvengeMedia/DankMaterialShell/issues/1732
        # settings = {
        #     theme = "dark";
        #     dynamicTheming = true;
        # };

        clipboardSettings = {
            maxHistory = 25;
            maxEntrySize = 5242880; # 5MB
            autoClearDays = 1;
            clearAtStartup = true;
            disabled = false;
            disableHistory = false;
            disablePersist = true;
        };

        systemd = {
            enable = true;
            restartIfChanged = true;
        };

        # Core features
        enableSystemMonitoring = true;     # System monitoring widgets (dgop)
        enableVPN = true;                  # VPN management widget
        enableDynamicTheming = true;       # Wallpaper-based theming (matugen)
        enableAudioWavelength = true;      # Audio visualizer (cava)
        enableCalendarEvents = false;      # Calendar integration (khal)
        enableClipboardPaste = true;       # Pasting items from the clipboard (wtype)

        # Plugins
        plugins = {
            calculator.enable = true;
            emojiLauncher.enable = true;
            dankDiskUsage.enable = true;
        };
    };

    # Create configuration files if they do not exist
    ## See https://danklinux.com/docs/dankmaterialshell/compositors#niri-configuration
    systemd.user.services.dms.serviceConfig.ExecStartPre = initScript;

    programs.dsearch = {
        enable = true;
        config = {
            index_path = "~/.cache/danksearch/index";
            max_file_bytes = 2097152; # 2MB
            worker_count = 4;

            auto_reindex = false;
            reindex_interval_hours = 24;

            text_extensions = [
                ".txt" ".md" ".go" ".py" ".js" ".ts"
                ".jsx" ".tsx" ".json" ".yaml" ".yml"
                ".toml" ".html" ".css" ".rs" ".nix"
            ];

            index_paths = [
                {
                    path = "~/";
                    max_depth = 0; # no limit
                    exclude_hidden = true;
                    exclude_dirs = [];
                }
            ];
        };
    };
}
