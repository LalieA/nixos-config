{ pkgs, ...}:

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
        extraGroups = [ "wheel" "networkmanager" "docker" "vboxusers" "wireshark" ];
    };


    ## NETWORK
    # Disable IPv6
    networking.enableIPv6  = false;


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

    # Enable VirtualBox
    virtualisation.virtualbox.host = {
        enable = true;
        enableExtensionPack = true;
    };

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
