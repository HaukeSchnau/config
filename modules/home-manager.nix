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
    cd = "z";
    ff = "fzf";
    devdash = "zellij -l ~/.config/zellij/layouts/dev-dashboard.kdl";
    lg = "lazygit";
    ld = "lazydocker";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    SSH_AUTH_SOCK = "/Users/haukeschnau/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock";
    ANDROID_HOME = "/Users/haukeschnau/Library/Android/sdk";
    XDG_CONFIG_HOME = "/Users/haukeschnau/.config";
  };

  programs = {
    firefox.enable = true;
    neovim.enable = true;
    bun.enable = true;
    btop.enable = true;
    yt-dlp.enable = true;
    lazydocker.enable = true;
    lazysql.enable = true;
    go.enable = true;
    jujutsu.enable = true;
    uv.enable = true;
    
    ghostty = {
      enable = true;
      package = pkgs.ghostty-bin;
      settings = {
        macos-titlebar-style = "tabs";
        background-opacity = 0.95;
        theme = "catppuccin-macchiato";
        window-padding-x = 12;
        selection-invert-fg-bg = "true";
        macos-option-as-alt = "left";
        mouse-hide-while-typing = "true"; 
        background-blur = 10;
        quick-terminal-position = "center";
        keybind = [
          "global:ctrl+shift+grave_accent=toggle_quick_terminal"
          "shift+enter=text:\x1b\r"
        ];
      };
    };

    obsidian.enable = true;
    spotify-player.enable = true;
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  # TODO: Consolidate into projects where they are needed
  home.packages = with pkgs; [
    # CLI tools
    # bitwarden-cli
    hyperfine
    typst
    step-cli
    xh

    nodejs_24

    # Development tools
    alejandra
    dive
    fastlane
    cocoapods
    flutter
    code-cursor
    jetbrains-toolbox
    # darwin.xcode

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

  # home.file."/Users/haukeschnau/Library/Application Support/Cursor/User/settings.json".source = config.lib.file.mkOutOfStoreSymlink "./cursor/settings.json";
  # home.file."/Users/haukeschnau/Library/Application Support/Cursor/User/keybindings.json".source = config.lib.file.mkOutOfStoreSymlink "./cursor/keybindings.json";

  home.file."/Users/haukeschnau/Library/Application Support/Cursor/User/settings.json".source = config.lib.file.mkOutOfStoreSymlink /Users/haukeschnau/config/modules/cursor/settings.json;
  home.file."/Users/haukeschnau/Library/Application Support/Cursor/User/keybindings.json".source = config.lib.file.mkOutOfStoreSymlink /Users/haukeschnau/config/modules/cursor/keybindings.json;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
