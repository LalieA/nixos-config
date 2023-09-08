{
  description = "Lalie's NixOS flake";

  ### Inputs ###
  inputs = {
    # Official NixOS package source
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # home-manager, used to manage user configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      # `inputs.nixpkgs` of home manager must be kept consistent with `inputs.nixpkgs` of the current flake
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # VSCode extensions
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  ### Outputs ###
  outputs = { self, nixpkgs, home-manager, nix-vscode-extensions, ...}@inputs: {
    nixosConfigurations = {
      # hostname = "nixos"
      "nixos" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # NixOS host
          ./hosts/virtualbox

          # home-manager
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.lalie = import ./home;
          }
        ];
      };
    };
  };

  nixConfig = {
    experimental-features = ["nix-command" "flakes"];

    substituters = [
      "https://cache.nixos.org"
    ];

    extra-substituers = [
      "https://nix-community.cachix.org"
    ];

    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };
}
