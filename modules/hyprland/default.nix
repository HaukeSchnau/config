{pkgs, ...}: {
  home.packages = with pkgs; [
    wofi
    waybar
    dunst
    libnotify
    swww
    kitty
    rofi-wayland
  ];

  home.file = {
    ".config/hypr/hyprland.conf".source = ./hyprland.conf;
  };
}
