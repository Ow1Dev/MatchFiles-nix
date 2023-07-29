{
  config,
  pkgs,
  inputs,
  ...
}: {
    home.packages = with pkgs; [
        neovim-unwrapped
        zsh
        starship
        dconf
    ];
}
