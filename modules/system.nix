{ pkgs, ...}:

{
    # Set your time zone.
    time.timeZone = "Europe/Paris";

    # Select internationalisation properties.
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

    # Users
    programs.zsh.enable = true;
    users.users.lalie = {
        hashedPassword = "$6$rGxHh9Bkaz2AWlfk$a797yyofU8ybDiKbsPOKGuaHX5Hc/EsPkFe.n00MZQ3zsOu8J8tDbw92GwQB.LRSxcgEJ.AM2gRVJ.QBr5x2V0";
        isNormalUser = true;
        shell = pkgs.zsh;
        extraGroups = [ "wheel" "networkmanager" "docker" ];
    };

    # Fonts
    fonts.fontconfig.enable = true;
    fonts.fonts = with pkgs; [
        meslo-lgs-nf
    ];

    # Run Electron-based apps under Wayland
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

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
