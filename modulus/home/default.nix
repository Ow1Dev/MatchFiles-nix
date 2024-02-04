{ ... }: {
  imports = 
   [ (import ./nvim) ]
    ++ [ (import ./waybar) ]
    ++ [ (import ./hyprland) ]
    ++ [ (import ./starship) ]
    ++ [ (import ./rofi) ]
    ++ [ (import ./gtk) ]
    ++ [ (import ./kitty) ]
    ++ [ (import ./zsh) ]
    ++ [ (import ./tmux) ]
    ++ [ (import ./xdg) ]
    ++ [ (import ./packages) ];
}
