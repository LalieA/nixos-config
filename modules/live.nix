{ nixpkgs, pkgs, lib, ... }:

{
    imports = [
        ./hyprland.nix
    ];

    ## ISO
    isoImage = {
        isoName = lib.mkForce "nixos-live.iso";
        makeEfiBootable = true;
        makeUsbBootable = true;
        forceTextMode = true;
        squashfsCompression = "zstd -Xcompression-level 6";
    };

    ## HARDWARE TWEAKS
    # Bluetooth
    hardware.bluetooth.enable = true; # enables support for bluetooth
    hardware.bluetooth.powerOnBoot = false; # don't powers up bluetooth controller on boot
    services.blueman.enable = true; # enables bluetooth management service

    # Enable sound with pipewire
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };
    security.rtkit.enable = true;

    powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

    ## SYSTEM CONFIGURATION
    # Time zone
    time.timeZone = "Etc/UTC";

    # Internationalisation properties
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
    };

    networking = {
        # Keep NetworkManager instead of default wpa-supplicant
        wireless.enable = false;
        hostName = "live";
        useDHCP = lib.mkForce true;
        # Assign random MAC address at each connection
        networkmanager = {
            enable = true;
            wifi.scanRandMacAddress = true;
            wifi.macAddress = "random";
            ethernet.macAddress = "random";
        };
    };

    # Restart Tor deamon while changing network
    services.networkd-dispatcher = {
        enable = true;
        rules."restart-tor" = {
            onState = ["routable" "off"];
            script = ''
                #!${pkgs.runtimeShell}
                if [[ $IFACE == "wlan0" && $AdministrativeState == "configured" ]]; then
                    echo "Restarting Tor ..."
                    systemctl restart tor
                fi
                exit 0
            '';
        };
    };


    ## SYSTEM-WIDE PACKAGES
    # Pidgin plugins
    nixpkgs.config.packageOverrides = pkgs: with pkgs; {
        pidgin-with-plugins = pkgs.pidgin.override {
            plugins = [ pidgin-otr purple-matrix ];
        };
    };


    ## USERS
    programs.zsh.enable = true;
    users.users.live = {
        hashedPassword = "$6$rGxHh9Bkaz2AWlfk$a797yyofU8ybDiKbsPOKGuaHX5Hc/EsPkFe.n00MZQ3zsOu8J8tDbw92GwQB.LRSxcgEJ.AM2gRVJ.QBr5x2V0";
        isNormalUser = true;
        shell = pkgs.zsh;
        extraGroups = [ "wheel" "networkmanager" "docker" "wireshark" ];
    };


    ## MISC
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Fonts
    fonts.fontconfig.enable = true;
    fonts.packages = with pkgs; [
        meslo-lgs-nf
    ];

    # Enable Wireshark
    programs.wireshark.enable = true;

    # Enable GNOME Keyring (required by programs like ProtonVPN)
    services.gnome.gnome-keyring.enable = true;

    system.stateVersion = "23.11";
}
