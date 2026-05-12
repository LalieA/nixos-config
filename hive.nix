inputs:
let
    home-manager = inputs.home-manager;
    pkgs = import inputs.nixpkgs {
        system = "x86_64-linux"; # don't care, it will be overwritten by nodeNixpkgs
        config = { allowUnfree = true; };
    };
    pkgs-unstable = import inputs.nixpkgs-unstable {
        system = "x86_64-linux"; # idem
        config = { allowUnfree = true; };
    };
    commonModules = with inputs; [
        nur.modules.nixos.default
        { nixpkgs.overlays = [ inputs.nur.overlays.default ]; }
    ];
in
{
    meta = {
        nixpkgs = pkgs;
        specialArgs = { inherit inputs; inherit pkgs-unstable; };
    };
    defaults = {
        imports = commonModules;
    };

    ### DEPLOYMENTS ###

    # Tuxedo
    nixos = {
        networking.hostName = "nixos";
        imports = [
            # NixOS host
            ./hosts/tuxedo

            # Users
            home-manager.nixosModules.home-manager {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.lalie = import ./home;
                home-manager.extraSpecialArgs = { inherit inputs; inherit pkgs-unstable; };
            }
        ];
        deployment = {
            allowLocalDeployment = true;
            targetHost = null;
        };
    };
}
