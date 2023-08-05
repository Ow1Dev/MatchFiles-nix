{ pkgs
, config
, ...
}: {
  xdg.configFile."nvim".source = ../confs/nvim;

  home.packages = with pkgs; [
     nodejs
     gcc
     ripgrep
     lazygit
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    vimAlias = false;
    viAlias = false;
    vimdiffAlias = false;
    withRuby = false;
    withNodeJs = false;
    withPython3 = false;
  };
}

