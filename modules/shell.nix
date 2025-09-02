{pkgs, ...}: {
  programs = {
    fish = {
      enable = true;
      functions = {
        # nix = {
        #   command = "nix --extra-experimental-features nix-command --extra-experimental-features flakes shell fish";
        # };
        gitignore = "curl -sL https://www.gitignore.io/api/$argv";
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
