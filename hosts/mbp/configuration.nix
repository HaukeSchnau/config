{
  inputs,
  self,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/darwin/homebrew.nix
    inputs.home-manager.darwinModules.home-manager
  ];

  programs.fish.enable = true;
  users.users.haukeschnau = {
    home = "/Users/haukeschnau";
    shell = pkgs.fish;
  };
  system.primaryUser = "haukeschnau";

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  environment = {
    shells = with pkgs; [fish];

    systemPath = [
      "/opt/homebrew/bin"
      "/Users/haukeschnau/.bun/bin"
      "/Users/haukeschnau/go/bin"
    ];

    pathsToLink = ["/Applications"];
  };

  home-manager = {
    extraSpecialArgs = {
      inherit inputs self;
    };
    users.haukeschnau = {
      imports = [../../modules/home-manager.nix];
    };
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  # use touch id for sudo
  security = {
    pam.services.sudo_local = {
      enable = true;
      touchIdAuth = true;
    };
  };

  system = {
    startup = {
      chime = false;
    };
    defaults = {
      loginwindow = {
        GuestEnabled = false;
        DisableConsoleAccess = true;
      };
      finder = {
        AppleShowAllFiles = true;
        AppleShowAllExtensions = true;
        _FXShowPosixPathInTitle = true;
        ShowPathbar = true;
        ShowStatusBar = true;
      };
      NSGlobalDomain = {
        AppleShowAllFiles = false;
        AppleShowAllExtensions = false;
        AppleShowScrollBars = "Always";
        # InitialKeyRepeat = 14;
        # KeyRepeat = 3;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticWindowAnimationsEnabled = false;
      };
      # screencapture = {
      #   type = "jpg";
      # };
    };
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
