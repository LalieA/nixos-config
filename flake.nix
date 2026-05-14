{
  ### Inputs ###
  inputs = {
    # Flake utils
    flake-utils.url = "github:numtide/flake-utils";

    # Official NixOS package source (release, default)
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    # Official NixOS package source (unstable, for new packages)
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # home-manager, used to manage user configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Colmena, to handle NixOS deployments
    colmena = {
      url = "github:zhaofengli/colmena/release-0.4.x";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    # Disko, for declarative disk partitionning
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Impermanence, used to define persistent files for temporary rootfs
    impermanence = {
      url = "github:nix-community/impermanence";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix User Repository (NUR)
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # VSCode extensions
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Niri
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Dank-Material-Shell
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Dank-Material-Shell plugins
    dms-plugins = {
      url = "github:AvengeMedia/dms-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Dank Search
    danksearch = {
      url = "github:AvengeMedia/danksearch";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  ### Outputs ###
  outputs = {self, flake-utils, nixpkgs, nixpkgs-unstable, home-manager, colmena, disko, impermanence, nur, ...}: {
    colmena = import ./hive.nix self.inputs;

    # BUILD MINIMAL ISO IMAGE:          nix build .#nixosConfigurations.iso.config.system.build.isoImage
    # BURN ISO TO USB (4GB is enough):  sudo dd if=./result/iso/nixos-live-minimal.iso of=/dev/sdX bs=1M status=progress oflag=sync
    # DEPLOY FIRST TIME:                nixos-anywhere --flake .#<config-name> root@<machine-ip>
    # DEPLOY REGULAR:                   colmena apply --impure --reboot --on <config-name>

    # If the target do not have internet access, and nixos-anywhere fails trying to get kexec tarball, download it locally:
    #   nix build github:nix-community/nixos-images#packages.x86_64-linux.kexec-installer-nixos-stable-noninteractive
    # then specify tarball location: nixos-anywhere --flake .#<config-name> root@<machine-ip> --kexec ./result/nixos-kexec-*.tar.gz --build-on local

    nixosConfigurations = (colmena.lib.makeHive self.outputs.colmena).nodes // {
      "iso" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = ([
          ./hosts/live-minimal
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-base.nix"
          disko.nixosModules.disko
          ({
            # Set the nix store size enough to handle the "real" NixOS configuration to be copied on the target.
            # Can be seen through: nix path-info -Sh .#nixosConfigurations.<computer-hostname>.config.system.build.toplevel
            #
            # /!\
            # As full closure size can be high (~30GB) and devices may not have this amount of RAM nor storage available on the live USB stick,
            # I suggest to make this partition large enough for an almost Disko-only configuration to create initial disk partitionning (deployed with nixos-anywhere),
            # then boot that new system from target's disk, and continue deploying the entire NixOS configuration with Colmena.
            boot.postBootCommands = ''
              mount -o remount,size=5G /nix/.rw-store || true
            '';
          })
        ]);
      };
    };
  } // flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.default = pkgs.mkShell {
        packages = [
          pkgs.nixos-anywhere
          pkgs.colmena

          pkgs.sops
          pkgs.age
          pkgs.ssh-to-age
        ];
        shellHook = ''
        '';
      };
    });

  nixConfig = {
    experimental-features = ["nix-command" "flakes"];

    substituters = [
      "https://cache.nixos.org"
    ];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];

  };
}
