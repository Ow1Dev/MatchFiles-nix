{ config
, pkgs
, inputs
, ...
}: {
  xdg.configFile."nix/inputs/nixpkgs".source = inputs.nixpkgs.outPath;
  nix.registry.nixpkgs.flake = inputs.nixpkgs;

  home.sessionVariables = rec {
    EDITOR = "nvim";
    GIT_EDITOR = "nvim";
    TERMINAL = "kitty";
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "gtk3";
    XCURSOR_SIZE = "34";
    NIX_PATH = "nixpkgs=${config.xdg.configHome}/nix/inputs/nixpkgs$\{NIX_PATH:+:$NIX_PATH}";
    TLDR_CACHE_DIR = config.xdg.cacheHome;
    DOTNET_ROOT = "${pkgs.dotnet-sdk}";
    OMNISHARP_LANGUAGE_SERVER = "${pkgs.omnisharp-roslyn}"; # todo this need to go some where else
  };

  # disable man pages
  manual.manpages.enable = false;
}

