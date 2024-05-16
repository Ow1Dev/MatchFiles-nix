{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
    };
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
  };

  outputs = { nixpkgs, home-manager, hyprland, ... }@inputs:
    let
      mkSystem = pkgs: system: hostname:
        pkgs.lib.nixosSystem {
          system = system;
          modules = [
            { networking.hostName = hostname; }
            (./. + "/hosts/${hostname}")
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }
            hyprland.nixosModules.default
            { programs.hyprland.enable = true; }
          ];
          specialArgs = { inherit inputs; };
        };

    in
    {
      nixosConfigurations = {
        # Now, defining a new system is can be done in one line
        #                                Architecture   Hostname
        laptop = mkSystem inputs.nixpkgs "x86_64-linux" "laptop";
      };


      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
    };
}
