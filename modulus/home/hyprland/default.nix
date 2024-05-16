{ pkgs
, lib
, ...
}:
let
  _ = lib.getExe;
  screenshotScript =
    let
      inherit (pkgs) wayshot slurp;
    in
    pkgs.writeShellScriptBin "wayshot-ss" ''
      WORKSPACES="$(hyprctl monitors -j | jq -r 'map(.activeWorkspace.id)')"
      WINDOWS="$(hyprctl clients -j | jq -r --argjson workspaces "$WORKSPACES" 'map(select([.workspace.id] | inside($workspaces)))' )"
      GEOM=$(echo "$WINDOWS" | jq -r '.[] | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | ${_ slurp} -f '%x %y %w %h')
      ${_ wayshot} -s "$GEOM" --stdout ''${#:+"$@"}
    '';
in
{
  home.packages = with pkgs; [
    hyprpaper
    brightnessctl
    wl-clipboard
    networkmanagerapplet
    screenshotScript
  ];


  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    extraConfig = builtins.readFile ./confs/hyprland.conf;
  };

  xdg.configFile."hypr/hyprpaper.conf".text =
    builtins.readFile ./confs/hyprpaper.conf;

  xdg.configFile."hypr/scripts".source = ./scripts;
}
