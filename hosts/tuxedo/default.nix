{ ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../../modules/system.nix
        ../../modules/hyprland.nix
    ];

    # Bootloader
    boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
    };

    # Networking
    networking = {
        hostName = "nixos";
        networkmanager.enable = true;
        # wireless.enable = true;

        # Configure network proxy if necessary
        # proxy.default = "http://user:password@proxy:port/";
        # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    };

    # Bluetooth
    hardware.bluetooth.enable = true; # enables support for bluetooth
    hardware.bluetooth.powerOnBoot = false; # don't powers up bluetooth controller on boot
    services.blueman.enable = true; # enables bluetooth management service

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable sound with pipewire.
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        #jack.enable = true;

        # use the example session manager (no others are packaged yet so this is enabled by default,
        # no need to redefine it in your config for now)
        #media-session.enable = true;
    };
    security.rtkit.enable = true;

    # TUXEDO Control Center - needs deprecated (and insecure) packages
    # hardware.tuxedo-control-center.enable = true;
    nixpkgs.config.permittedInsecurePackages = [
        "electron-25.9.0"
    ];

    system.stateVersion = "23.11";
}
