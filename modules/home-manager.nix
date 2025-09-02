{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./git.nix
    ./shell.nix
    # ./hyprland/default.nix
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  programs = {
    firefox.enable = true;
    neovim.enable = true;
  };

  home.shellAliases = {
    vim = "nvim";
    v = "nvim";
    ls = "eza --icons";
    cat = "bat";
    htop = "btop";
    pip = "uv pip";
    ranger = "yazi";
    y = "yazi";
    find = "fd";
    grep = "rg -i";
    du = "dust";
    tmux = "zellij";
    # cd = "z";
    ff = "fzf";
    devdash = "zellij -l ~/.config/zellij/layouts/dev-dashboard.kdl";
    lg = "lazygit";
    ld = "lazydocker";
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  # TODO: Consolidate into projects where they are needed
  home.packages = with pkgs; [
    # CLI tools
    btop
    # bitwarden-cli
    hyperfine
    typst
    yt-dlp
    step-cli
    xh

    # JavaScript
    bun
    nodejs_24

    # Development tools
    alejandra
    dive
    lazydocker
    go
    jujutsu
    uv
    fastlane
    cocoapods
    direnv
    flutter
    code-cursor
    ghostty-bin
    jetbrains-toolbox
    # darwin.xcode

    # Applications
    obsidian
    raycast
    slack
    notion-app
    spotify
    stats
    netbird
    karabiner-elements
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

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/schnau/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
