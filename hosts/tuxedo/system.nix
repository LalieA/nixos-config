{ pkgs, ...}:
let
    dofus = import ../../modules/misc/ankama-launcher.nix {inherit pkgs;};
in
{
    ## BOOT
    boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
    };

    ## SYSTEM
    # Time zone
    time.timeZone = "Europe/Paris";

    # Internationalisation properties
    i18n.defaultLocale = "fr_FR.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "fr_FR.UTF-8";
        LC_IDENTIFICATION = "fr_FR.UTF-8";
        LC_MEASUREMENT = "fr_FR.UTF-8";
        LC_MONETARY = "fr_FR.UTF-8";
        LC_NAME = "fr_FR.UTF-8";
        LC_NUMERIC = "fr_FR.UTF-8";
        LC_PAPER = "fr_FR.UTF-8";
        LC_TELEPHONE = "fr_FR.UTF-8";
        LC_TIME = "fr_FR.UTF-8";
    };


    ## USERS
    programs.zsh.enable = true;
    users.users.lalie = {
        hashedPassword = "$6$rGxHh9Bkaz2AWlfk$a797yyofU8ybDiKbsPOKGuaHX5Hc/EsPkFe.n00MZQ3zsOu8J8tDbw92GwQB.LRSxcgEJ.AM2gRVJ.QBr5x2V0";
        isNormalUser = true;
        shell = pkgs.zsh;
        extraGroups = [ "wheel" "networkmanager" "wireshark" ];
    };


    ## NETWORK
    networking = {
        hostName = "nixos";
        enableIPv6 = false; # disable IPv6
        networkmanager = {
            enable = true;
            wifi.scanRandMacAddress = true;
            wifi.macAddress = "random";
            ethernet.macAddress = "random";
            plugins = with pkgs; [
                networkmanager-openconnect
            ];
        };
    };


    ## CONNECTIVITY
    # CUPS
    services.printing.enable = true;


    ## SECURITY
    # Enable GNOME Keyring (required by programs like ProtonVPN)
    services.gnome.gnome-keyring.enable = true;


    ## MISC OPTIONS
    # Tuxedo hardware
    hardware.tuxedo-rs = {
        enable = true;
        tailor-gui.enable = true;
    };

    # Auto-mount USB drives
    services.gvfs.enable = true;
    services.udisks2.enable = true;

    # Flipper Zero support
    hardware.flipperzero.enable = true;

    # QMK & OpenRGB keyboards support
    hardware.keyboard.qmk.enable = true;
    services.hardware.openrgb.enable = true;

    # DisplayLink
    services.xserver.videoDrivers = [ "displaylink" ];
    systemd.services.dlm.wantedBy = [ "multi-user.target" ];
    environment.variables = {
        WLR_EVDI_RENDER_DEVICE = "/dev/dri/card1";
    };

    # Fonts
    fonts.fontconfig.enable = true;
    fonts.packages = with pkgs; [
        meslo-lgs-nf
    ];

    # Wireshark
    programs.wireshark.enable = true;


    ## MISC PACKAGES
    environment.systemPackages = with pkgs; [
        # Brightness
        brightnessctl

        # QMK, OpenRGB
        qmk
        openrgb

        # DisplayLink
        displaylink

        # Gaming
        wine-staging
        vulkan-tools
        (lutris.override {
            extraLibraries =  pkgs: [ cdrdao dosbox ];
        })

        # Ankama-Launcher / Dofus
        dofus

        # LibreOffice
        libreoffice-qt
        hunspell
        hunspellDicts.en-us
        hunspellDicts.fr-any

        # System
        btop
        ungoogled-chromium
        openconnect
        smartmontools
    ];


    ## NIX
    nixpkgs.config.allowUnfree = true;
    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 1w";
    };
    nix.settings = {
        experimental-features = ["nix-command" "flakes"];
        auto-optimise-store = true;
    };
}
