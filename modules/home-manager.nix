{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./git.nix
    ./shell/default.nix
    ./development/default.nix
    # ./hyprland/default.nix
  ];

  home = {
    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "25.05"; # Please read the comment before changing.

    shellAliases = {
      devdash = "zellij -l ~/.config/zellij/layouts/dev-dashboard.kdl";
      ld = "lazydocker";
    };

    sessionVariables = {
      SSH_AUTH_SOCK = "/Users/haukeschnau/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock";
      XDG_CONFIG_HOME = "/Users/haukeschnau/.config";
    };

    # The home.packages option allows you to install Nix packages into your
    # environment.
    # TODO: Consolidate into projects where they are needed
    packages = with pkgs; [
      # CLI tools
      # bitwarden-cli
      hyperfine
      typst
      step-cli
      xh

      # Development tools
      alejandra
      dive

      # Applications
      raycast
      slack
      notion-app
      spotify
      stats
      netbird
      aldente

      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
    ];
  };

  programs = {
    firefox.enable = true;
    yt-dlp.enable = true;
    lazydocker.enable = true;
    lazysql.enable = true;
    jujutsu.enable = true;
    obsidian.enable = true;
    home-manager.enable = true;
  };
}
