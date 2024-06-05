{ ... }: {
  imports =
    [ (import ./nvim) ]
    ++ [ (import ./starship) ]
    ++ [ (import ./tmux) ]
    ++ [ (import ./xdg) ]
    ++ [ (import ./zsh) ];
}
