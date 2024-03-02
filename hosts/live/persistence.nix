{
  environment.persistence."/persistent" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/systemd/coredump"
    ];
    files = [];
    users.live = {
      directories = [
        ".local/state/nix/profiles" # Home Manager
        "Downloads"
        "Documents"
        ".tor project/firefox" # Tor Browser
        ".librewolf" # Librewolf
        ".thunderbird" # Thunderbird
        ".purple" # Pidgin
        ".config/gajim" # Gajim
        ".config/onionshare" # OnionShare
        { directory = ".gnupg"; mode = "0700"; }
        { directory = ".ssh"; mode = "0700"; }
      ];
    };
  };
}
