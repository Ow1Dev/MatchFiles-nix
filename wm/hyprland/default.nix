
{ ... }: {
  imports = 
    [ (import ./hyprland) ]
    ++ [ (import ./waybar) ]
    ++ [ (import ./rofi) ]
    ++ [ (import ./gtk) ]
    ++ [ (import ./kitty) ]
    ++ [ (import ./wlogout) ]
    ++ [ (import ./packages) ];
}
