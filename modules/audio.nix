{ pkgs, lib, ... }:

{
    # Sound with pipewire
    services.pulseaudio.enable = lib.mkDefault false;
    services.pipewire = {
        enable = lib.mkDefault true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        #jack.enable = true;
    };
    security.rtkit.enable = lib.mkDefault true;

    environment.systemPackages = with pkgs; [
        pulseaudio
        wireplumber
    ];
}
