{ pkgs, lib, ... }:

{
    # Enable support for bluetooth
    hardware.bluetooth.enable = lib.mkDefault true;

    # Don't power up bluetooth controller on boot
    hardware.bluetooth.powerOnBoot = lib.mkDefault false;

    # Enable bluetooth management service
    services.blueman.enable = lib.mkDefault true;

    # Use bluetooth headset buttons to control media player
    systemd.user.services.mpris-proxy = lib.mkDefault {
        description = "Mpris proxy";
        after = [ "network.target" "sound.target" ];
        wantedBy = [ "default.target" ];
        serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
    };
}
