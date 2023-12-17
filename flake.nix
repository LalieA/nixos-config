{
  description = "Lalie's NixOS flake";

  ### Inputs ###
  inputs = {
    # Official NixOS package source
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

    # home-manager, used to manage user configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
    home-manager,
    nix-vscode-extensions,
    alacritty-theme,
    nur,
    # tuxedo-nixos,
    ...}@inputs: {
    nixosConfigurations = {
      # hostname = "nixos"
      "nixos" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # NixOS host
          ./hosts/tuxedo

          # home-manager
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.lalie = import ./home;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }

          # alacritty themes
          { nixpkgs.overlays = [ alacritty-theme.overlays.default ]; }

          # Nix User Repository (NUR)
          nur.nixosModules.nur
          { nixpkgs.overlays = [ nur.overlay ]; }

          # TUXEDO Control Center
          # tuxedo-nixos.nixosModules.default
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
