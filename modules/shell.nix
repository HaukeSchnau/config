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

    bat.enable = true;
    starship.enable = true;
    yazi.enable = true;
    zoxide.enable = true;
    fzf.enable = true;
  };

  home.packages = with pkgs; [
    carapace
    eza
    fd
    fselect
    dua
    dust
    just
    poppler
    resvg
    ripgrep
    ripgrep-all
    p7zip
    zellij
  ];
}
