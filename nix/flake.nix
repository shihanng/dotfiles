{
  description = "Home Manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, darwin, ... }:
    {
      homeConfigurations.shihanng = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          {
            home = {
              username = "shihanng";
              homeDirectory = "/home/shihanng";
            };
          }
          ./home.nix
          ./home_linux.nix
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
      darwinConfigurations = {
        shihanng = darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          modules = [
            {
              services.nix-daemon.enable = true;
              nix.package = nixpkgs.legacyPackages.x86_64-darwin.nix;
            }
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."shi.han.ng" = {
                imports = [ ./home.nix ];
              };

              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
            }
          ];
        };
      };
    };
}
