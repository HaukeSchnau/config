{
  inputs,
  self,
  pkgs,
  ...
}: {
  imports = [
    inputs.home-manager.darwinModules.home-manager
  ];

  programs.fish.enable = true;
  users.users.haukeschnau = {
    home = "/Users/haukeschnau";
    shell = pkgs.fish;
  };

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  home-manager = {
    extraSpecialArgs = {
      inherit inputs self;
    };
    users.haukeschnau = {
      imports = [../../modules/home-manager.nix];
    };
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  nixpkgs.config.allowUnfree = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
