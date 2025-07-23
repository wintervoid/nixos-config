{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "SUPER";

      bind = [
        "$mod, RETURN, exec, alacritty"
        "$mod, Q, killactive"
        "$mod, D, exec, rofi -show drun"
      ];

      monitor = [
        "eDP-1, preferred, auto, 1"
      ];

      exec-once = [
        "waybar"
        "hyprpaper"
      ];
    };
  };

  home.packages = with pkgs; [
    hyprland
    alacritty
    rofi
    waybar
    swww
  ];
}

