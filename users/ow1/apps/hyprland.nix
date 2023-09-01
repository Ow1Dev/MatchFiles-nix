{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    hyprpaper
    brightnessctl
    wl-clipboard
  ];


  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ../confs/hypr/hyprland.conf;
  };

  xdg.configFile."hypr/hyprpaper.conf".text =
    builtins.readFile ../confs/hypr/hyprpaper.conf;
}
