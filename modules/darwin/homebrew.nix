{...}: {
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };

    caskArgs.no_quarantine = true;
    global.brewfile = true;

    casks = [
      "font-new-computer-modern"
      "karabiner-elements"
      "linear-linear"
      "mactex-no-gui"
      "orbstack"
      "zen"
    ];

    # CHECK NIX FIRST!
    brews = [
      "taproom"
    ];

    masApps = {
    };

    taps = [
    ];
  };
}
