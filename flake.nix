{
  description = "Nixos config flake";

  inputs = {
    # Where we get most of our software. Giant mono repo with recipes
    # called derivations that say how to build software.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Manages configs links things into your home directory
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Controls system level software and settings including fonts on MacOS
    darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    darwin,
    ...
  } @ inputs: {
    nixosConfigurations."tower" = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/tower/configuration.nix
        home-manager.nixosModules.default
      ];
    };

    darwinConfigurations."MacBook-Pro-von-Hauke" = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      specialArgs = {inherit inputs self;};
      modules = [
        ./hosts/mbp/configuration.nix
      ];
    };
  };
}
