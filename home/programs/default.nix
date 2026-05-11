{ ... }:

{
    imports = [
        ./direnv
        ./firefox
        ./git
        ./vscode
    ];

    # Auto-mount USB drives
    services.udiskie = {
        enable = true;
        notify = true;
    };

    # Connect virt-manager to QEMU/KVM by default
    dconf = {
        enable = true;
        settings = {
            "org/virt-manager/virt-manager/connections" = {
                autoconnect = ["qemu:///system"];
                uris = ["qemu:///system"];
            };
        };
    };

    # Swappy configuration (screenshots)
    home.file.".config/swappy/config".source = ./swappy.conf;
}
