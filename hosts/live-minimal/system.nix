{ nixpkgs, pkgs, lib, ... }:

{
    ## ISO
    image.baseName = lib.mkForce "nixos-live-minimal";
    isoImage = {
        makeEfiBootable = true;
        makeUsbBootable = true;
        forceTextMode = true;
    };


    ## SSH CONFIGURATION
    services.openssh = {
        enable = true;
        settings.PasswordAuthentication = false;
    };

    users.users."root".openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCZG6vYXuWcSiGmRRyTIEpMco7lROwJOevLbtL2kIZoZOtD7Ic/JWdHkaZNM2pIzRmLMksbcxN7jPHdXIp+6ytITWoJhAMiRWzHvWZToDRHTMZzsJQX0pTlGgQOBajexq4/puYCRTzHdEMnbUT9LL8ffLC0euZllfWdS4kZruL/Nid2R/hWMfkxY7oEUSU1WZHrwJIEz+JHTyDwpSd836lyt3znrkrMFdiKZUoSWY0SJtF06jV/2p2MoGtRTCtYBWnUUzEP4E1xuNpsiI2V0LbrGvJN/zZP32yvHch6kzUwa4mjR2gixJDg4Zpqb8GG4vTW73D6A0teiu4ZozZaPY2/1ya1InSO9UWdsAJSwJNiNvqzN+IyM+vGNKypeT1Ub4Tti0cXQJLVZJWXKqevyquMwY9SLzHswLMQq/ue5Ee63SYUA7I4eD6pyFlVGKDqAvqgPLclq9audjbGoluHpk40lA5/pcqmgmuDflyXtpvr/3eixMY7EcurgONHZvE9UB0= lalie@nixos"
    ];


    ## BOOTLOADER CONFIGURATION

    boot.loader.grub = {
        enable = true;
        configurationLimit = 1;
        efiSupport = true;
        efiInstallAsRemovable = true; # Otherwise /boot/EFI/BOOT/BOOTX64.EFI isn't generated
        extraEntries = ''
            menuentry "Reboot" {
                reboot
            }
            menuentry "Power off" {
                halt
            }
        '';
    };


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


    ## NETWORK
    networking = {
        hostName = "live";
        enableIPv6 = false; # disable IPv6
        networkmanager = {
            enable = true;
            wifi.scanRandMacAddress = true;
            wifi.macAddress = "random";
            ethernet.macAddress = "random";
            plugins = with pkgs; [
                networkmanager-openvpn
                networkmanager-openconnect
            ];
        };
    };

    # Fonts
    fonts.fontconfig.enable = true;
    fonts.packages = with pkgs; [
        meslo-lgs-nf
    ];


    ## MISC SYSTEM PACKAGES
    environment.systemPackages = with pkgs; [ ];


    ## NIX
    nixpkgs.config.allowUnfree = true;
}
