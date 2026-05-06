{ pkgs, lib, ... }:

{
    # Enable VirtualBox
    virtualisation.virtualbox.host = {
        enable = lib.mkDefault true;
        enableExtensionPack = true;
    };

    # Enable QEMU/KVM hypervisor
    virtualisation.libvirtd = {
        enable = lib.mkDefault true;
        qemu = {
            package = pkgs.qemu_kvm;
            runAsRoot = true;
            swtpm.enable = true;
        };
    };
    virtualisation.spiceUSBRedirection.enable = lib.mkDefault true;
    programs.virt-manager.enable = lib.mkDefault true;

    # Enable Docker in rootless mode
    virtualisation.docker = {
        enable = lib.mkDefault true;
        rootless = {
            enable = lib.mkDefault true;
            setSocketVariable = true;
        };
    };

    # Add user to extra groups
    users.users.lalie.extraGroups = [ "docker" "vboxusers" "libvirtd" ];
}
