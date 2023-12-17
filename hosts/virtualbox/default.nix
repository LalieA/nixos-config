{ ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../../modules/system.nix
        ../../modules/hyprland.nix
    ];

    # Bootloader
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking.networkmanager.enable = true;

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable sound with pipewire.
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # If you want to use JACK applications, uncomment this
        #jack.enable = true;

        # use the example session manager (no others are packaged yet so this is enabled by default,
        # no need to redefine it in your config for now)
        #media-session.enable = true;
    };

    # Make Hyprland working within VirtualBox VM
    environment.sessionVariables = {
        WLR_NO_HARDWARE_CURSORS = "1";
        WLR_RENDERER_ALLOW_SOFTWARE = "1";
    };

    system.stateVersion = "23.11";
}
