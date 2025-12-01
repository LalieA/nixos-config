{ pkgs, ...}:
let
    dofus = import ./misc/ankama-launcher.nix {inherit pkgs;};
in
{
    ## SYSTEM CONFIGURATION
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
        extraGroups = [ "wheel" "networkmanager" "docker" "vboxusers" "libvirtd" "wireshark" ];
    };


    ## NETWORK
    # Disable IPv6
    networking.enableIPv6  = false;


    ## MISC
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Enable Flipper Zero support
    hardware.flipperzero.enable = true;

    # Enable QMK & OpenRGB keyboards support
    hardware.keyboard.qmk.enable = true;
    services.hardware.openrgb.enable = true;

    # DisplayLink
    services.xserver.videoDrivers = [ "displaylink" ];
    systemd.services.dlm.wantedBy = [ "multi-user.target" ];
    environment.variables = {
        WLR_EVDI_RENDER_DEVICE = "/dev/dri/card1";
    };

    environment.systemPackages = with pkgs; [
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

        # Install Ankama-Launcher / Dofus
        dofus

        # Install LibreOffice
        libreoffice-qt
        hunspell
        hunspellDicts.en-us
        hunspellDicts.fr-any

        # Misc
        btop
        ungoogled-chromium
    ];

    # Fonts
    fonts.fontconfig.enable = true;
    fonts.packages = with pkgs; [
        meslo-lgs-nf
    ];

    # Enable Wireshark
    programs.wireshark.enable = true;

    # Enable GNOME Keyring (required by programs like ProtonVPN)
    services.gnome.gnome-keyring.enable = true;

    # Enable VirtualBox
    virtualisation.virtualbox.host = {
        enable = true;
        enableExtensionPack = true;
    };

    # Enable QEMU/KVM hypervisor
    virtualisation.libvirtd = {
        enable = true;
        qemu = {
            package = pkgs.qemu_kvm;
            runAsRoot = true;
            swtpm.enable = true;
            ovmf = {
            enable = true;
            packages = [(pkgs.OVMF.override {
                    secureBoot = true;
                    tpmSupport = true;
                }).fd];
            };
        };
    };
    virtualisation.spiceUSBRedirection.enable = true;
    programs.virt-manager.enable = true;

    # Enable Docker
    virtualisation.docker.enable = true;

    # Optimize storage
    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 1w";
    };
    nix.settings = {
        # Enable flakes globally
        experimental-features = ["nix-command" "flakes"];
        auto-optimise-store = true;
    };
}
