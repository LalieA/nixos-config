{ pkgs, ... }:

{
    # From https://wiki.nixos.org/wiki/Intel_Graphics
    services.xserver.videoDrivers = [ "modesetting" ];

    hardware.graphics = {
        enable = true;
        extraPackages = with pkgs; [
            # Required for modern Intel GPUs (Xe iGPU and ARC)
            intel-media-driver     # VA-API (iHD) userspace
            vpl-gpu-rt             # oneVPL (QSV) runtime

            # Optional (compute / tooling):
            intel-compute-runtime  # OpenCL (NEO) + Level Zero for Arc/Xe
        ];
    };
}
