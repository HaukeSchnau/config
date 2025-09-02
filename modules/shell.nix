{pkgs, ...}: {
  programs = {
    fish = {
      enable = true;
      functions = {
        gitignore = "curl -sL https://www.gitignore.io/api/$argv";

        setup-remote = ''
          git remote add origin ssh://git@git.schnau.dev:22222/schnau/$argv.git
          git remote set-url origin --push --add ssh://git@git.schnau.dev:22222/schnau/$argv.git
          git remote set-url origin --push --add git@github.com:HaukeSchnau/$argv.git
        '';
      };
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
    };

    carapace = {
      enable = true;
      enableFishIntegration = true;
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    yazi = {
      enable = true;
      enableFishIntegration = true;
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
    
    zellij = {
      enable = true;
      enableFishIntegration = true;
    };

    eza = {
      enable = true;
      enableFishIntegration = true;
      git = true;
    };

    direnv = {
      enable = true;
      # enableFishIntegration = true; 
    };

    ripgrep.enable = true;
    ripgrep-all.enable = true;
    fd.enable = true;
    bat.enable = true;
  };

  home.packages = with pkgs; [
    fselect
    dua
    dust
    just
    poppler
    resvg
    p7zip
  ];
}
