{
  description = "Lalie's NixOS flake";

  ### Inputs ###
  inputs = {
    # Official NixOS package source (release, default)
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

    # Official NixOS package source (unstable, for new packages)
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # home-manager, used to manage user configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Impermanence, used to define persistent files for temporary rootfs
    impermanence.url = "github:nix-community/impermanence";

    # VSCode extensions
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # alacritty themes
    alacritty-theme = {
      url = "github:alexghr/alacritty-theme.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix User Repository (NUR)
    nur.url = "github:nix-community/NUR";

    # anyrun
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # TUXEDO Control Center
    # tuxedo-nixos = {
    #   url = "github:blitz/tuxedo-nixos";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  ### Outputs ###
  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    impermanence,
    nix-vscode-extensions,
    alacritty-theme,
    nur,
    # tuxedo-nixos,
    ...}@inputs: {
    nixosConfigurations = let
      system = "x86_64-linux";
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config = { allowUnfree = true; };
      };

      commonModules = [
          # alacritty themes
          { nixpkgs.overlays = [ alacritty-theme.overlays.default ]; }

          # Nix User Repository (NUR)
          nur.nixosModules.nur
          { nixpkgs.overlays = [ nur.overlay ]; }
      ];

      mainConfiguration = {
        inherit system;
        modules = commonModules ++ [
          # NixOS host
          ./hosts/tuxedo

          # home-manager
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.lalie = import ./home;
            home-manager.extraSpecialArgs = { inherit inputs; inherit pkgs-unstable; };
          }

          # TUXEDO Control Center
          # tuxedo-nixos.nixosModules.default
        ];
      };

      liveConfiguration = {
        inherit system;
        modules = commonModules ++ [
          # NixOS live host
          ./hosts/live

          # home-manager
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.live = import ./home-live;
            home-manager.extraSpecialArgs = { inherit inputs; inherit pkgs-unstable; };
          }

          # Impermanence
          impermanence.nixosModules.impermanence
        ];
      };
    in {
      # Main system, hostname = "nixos"
      "nixos" = nixpkgs.lib.nixosSystem {
        inherit (mainConfiguration) system;
        inherit (mainConfiguration) modules;
      };

      # Live ISO, hostname = "live"
      ### build with: nix build .#nixosConfigurations.live.config.system.build.isoImage
      ### burn with: sudo dd if=./result/iso/nixos-live.iso of=/dev/sdX bs=1M status=progress oflag=sync
      ### add persistent partition with: sudo fdisk --wipe=never -t dos /dev/sdX
      ###                                 >  n, p, <Enter>, <Enter>, <Enter>, w
      ###                                sudo mkfs.ext4 -L persistent /dev/sdX3
      ###                                sudo mount /dev/sdX3 /mnt/persistent
      ###                                sudo chown -R :users /mnt/persistent
      ###                                sudo chmod -R g+rw /mnt/persistent
      ### NOTE: the first boot may fail because of Impermanence which currently cannot mount directories (stage 1) that are not yet created (stage 2).
      "live" = nixpkgs.lib.nixosSystem {
        inherit (liveConfiguration) system;
        modules = liveConfiguration.modules ++ [
          "${nixpkgs}/nixos/modules/installer/cd-dvd/iso-image.nix"
          "${nixpkgs}/nixos/modules/profiles/all-hardware.nix"
        ];
      };
    };
  };

  nixConfig = {
    experimental-features = ["nix-command" "flakes"];

    substituters = [
      "https://cache.nixos.org"
      "https://hyprland.cachix.org"
      "https://anyrun.cachix.org"
    ];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
    ];
  };
}
