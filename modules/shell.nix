{pkgs, ...}: {
  programs = {
    bat.enable = true;
    fish.enable = true;
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
