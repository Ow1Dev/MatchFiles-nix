{
  config,
  pkgs,
  inputs,
  ...
}: {
    home.packages = with pkgs; [
	zsh
        starship
    ];
}
