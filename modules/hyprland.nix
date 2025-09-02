{pkgs, ...}: {
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    wofi
    waybar
    dunst
    libnotify
    swww
    kitty
    rofi-wayland
  ];
}
