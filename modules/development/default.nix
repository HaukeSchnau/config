{
  pkgs,
  config,
  ...
}: {
  programs = {
    bun.enable = true;
    uv.enable = true;
    go.enable = true;
  };

  home = {
    packages = with pkgs; [
      code-cursor
      jetbrains-toolbox
      nodejs_24
      fastlane
      cocoapods
      flutter
      # darwin.xcode
    ];

    shellAliases = {
      pip = "uv pip";
      npx = "bunx";
      pnpx = "bunx";
      python = "python3";
      c = "open $1 -a \"Cursor\"";
    };

    sessionVariables = {
      ANDROID_HOME = "/Users/haukeschnau/Library/Android/sdk";
    };

    file."/Users/haukeschnau/Library/Application Support/Cursor/User/settings.json".source = config.lib.file.mkOutOfStoreSymlink /Users/haukeschnau/config/modules/development/settings.json;
    file."/Users/haukeschnau/Library/Application Support/Cursor/User/keybindings.json".source = config.lib.file.mkOutOfStoreSymlink /Users/haukeschnau/config/modules/development/keybindings.json;
  };
}
